# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(email: 'test@test.com')
  }

  it "Should be valid with a valid email" do
    expect(subject).to be_valid
  end

  it "Should not be valid with a blank email" do
    subject.email = ""
    expect(subject).to be_invalid
  end

  it "Should not be valid with a bad format email address" do
    subject.email = "invalidformat"
    expect(subject).to be_invalid
  end

end
