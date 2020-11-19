# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Check a Task', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(email: 'test@user.com', password: 'password', password_confirmation: 'password')
  end

  before(:each) do
    sign_in user
    Task.create(title: 'Title test', user: user)
  end

  scenario 'should check the task on index page' do
    visit tasks_path
    click_on 'Check'
    expect(page).to have_content('Task successfully updated')
    expect(page).to have_content('Done')
  end
end
