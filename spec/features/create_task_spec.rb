# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create a Task', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(email: "test@user.com", password: "password", password_confirmation: "password")
  end

  before(:each) do
    sign_in user
  end

  scenario 'with valid input' do
    visit new_task_path
    fill_in 'Title', with: 'Title test'
    click_on 'Create Task'
    expect(page).to have_content('Task successfully created')
    visit tasks_path
    expect(page).to have_content('Title test')
  end

  scenario 'with invalid input' do
    visit new_task_path
    fill_in 'Description', with: 'description test'
    click_on 'Create Task'
    expect(page).to have_content('Title can\'t be blank')
    visit tasks_path
    expect(page).not_to have_content('Title test')
  end
end
