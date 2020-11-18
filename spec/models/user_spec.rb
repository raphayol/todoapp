# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(email: 'test@test.com', password: 'password_test', password_confirmation: 'password_test')
  end

  it 'Should be valid with a valid email' do
    expect(subject).to be_valid
  end

  it 'Should not be valid with a blank email' do
    subject.email = ''
    expect(subject).to be_invalid
  end

  it 'Should not be valid with a bad format email address' do
    subject.email = 'invalidformat'
    expect(subject).to be_invalid
  end

  it 'Remove a user should remove associated tasks' do
    task = Task.create(title: 'test task', user: subject)
    subject.destroy
    expect(Task.exists?(task.id)).to eq(false)
  end
end
