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

  before_validation :set_default_order
  after_save :shift_order

  private

  def set_default_order
    return if order_index.present?

    self.order_index = Task.where(user_id: user_id).count
  end

  def shift_order
    return if Task.where(user_id: user_id, order_index: order_index).count.zero?

    task_to_shift = Task.where('order_index >= ?', order_index).where.not(id: id)
    new_order = order_index
    task_to_shift.each do |task|
      break if task.order_index > new_order

      new_order += 1
      task.update_columns(order_index: new_order)
    end
  end
end
