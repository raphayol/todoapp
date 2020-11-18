# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  description :text
#  done        :boolean          default(FALSE)
#  due_date    :datetime
#  order_index :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid
#
class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :order_index, numericality: { greater_than_or_equal_to: 0 }
  #validates :order_index, numericality: { less_or_equal_to: 0 }

  before_validation :set_default_order
  after_save :reorder_tasks
  after_destroy :shift_down_next_tasks

  private

  def max_order
    return 0 unless user.present?

    # Maximum value for order_index
    user.tasks.where.not(id: id).count
  end

  def set_default_order
    if order_index.nil? || order_index > max_order
      self.order_index = max_order
    elsif order_index.negative?
      self.order_index = 0
    end
  end

  def previous_associated_tasks
    # return all user tasks different than the current task, sorted by their order_index
    user.tasks.where('order_index <= ?', order_index).where.not(id: id).sort_by(&:order_index)
  end

  def next_associated_tasks
    # return all user tasks different than the current task, sorted by their order_index
    user.tasks.where('order_index >= ?', order_index).where.not(id: id).sort_by(&:order_index)
  end

  def reorder_tasks
    if previous_associated_tasks.count > order_index
      # Moving task UP
      # Take all next or equal step and shift it down adding it 1
      shift_down_next_tasks
    elsif previous_associated_tasks.count <= order_index
      # Moving task DOWN
      # Take all previous or equal step, sort them and set order equal to index
      shift_up_previous_tasks
    end
  end

  def shift_up_previous_tasks
    previous_associated_tasks.each_with_index do |task, index|
      task.update_columns(order_index: index) if index != task.order_index
    end
  end

  # On task deletion we have to shift down next tasks
  def shift_down_next_tasks
    return if next_associated_tasks.empty?

    # Shift down next task order_index starting
    # from the current index if the current object is deleted
    # from the next index if the current object exists
    new_order = destroyed? ? order_index : order_index + 1

    next_associated_tasks.each do |task|
      task.update_columns(order_index: new_order)
      new_order += 1
    end
  end
end
