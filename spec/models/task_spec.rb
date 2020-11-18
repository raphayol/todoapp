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
require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create(email: 'user@test.com', password: 'password_test', password_confirmation: 'password_test')
  end

  subject do
    described_class.create(title: 'My 1st todo task test', user_id: user.id)
  end

  it 'Should be valid with a user and a title' do
    expect(subject).to be_valid
  end

  it 'Should not be valid with a blank title' do
    subject.title = ''
    expect(subject).to be_invalid
  end

  it 'Should not be valid without associated user' do
    subject.user_id = nil
    expect(subject).to be_invalid
  end

  it 'Should set the task order automatically' do
    expect(subject.order_index).to eq(0)
  end

  it 'Should not be able to use a negative order' do
    subject.order_index = -1
    expect(subject).to be_invalid
  end

  it 'Should increment the task order_index regarding the other user task' do
    first_task = described_class.create(title: 'My 1st todo task test', user_id: user.id)
    expect(first_task.order_index).to eq(0)
    second_task = described_class.create(title: 'My 2nd todo task test', user_id: user.id)
    expect(second_task.order_index).to eq(1)
  end

  it 'Should shift related user task order_indexes if needed' do
    first_task = described_class.create(title: 'My 1st todo task test', user_id: user.id)
    expect(first_task.order_index).to eq(0)
    second_task = described_class.create(title: 'My 2nd todo task test', user_id: user.id)
    expect(second_task.order_index).to eq(1)
    second_task.update(order_index: 0)
    expect(second_task).to be_valid
    expect(first_task).to be_valid
    expect(second_task.order_index).to eq(0)
    first_task.reload
    expect(first_task.order_index).to eq(1)
  end
end
