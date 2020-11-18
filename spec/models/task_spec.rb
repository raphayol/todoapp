# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  Task        :string
#  description :text
#  done        :boolean
#  due_date    :datetime
#  order       :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create(email: 'user@test.com')
  end

  subject do
    described_class.new(title: 'test@test.com', user_id: user.id)
  end

  it 'Should be valid with a user and a title' do
    expect(subject).to be_valid
  end

  it 'Should not be valid with a blank title' do
    subject.title = ''
    expect(subject).to be_invalid
  end

  it 'Should not be valid without associated user' do
    subject.user = nil
    expect(subject).to be_invalid
  end
end
