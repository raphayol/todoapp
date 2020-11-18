# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete a Task', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(email: "test@user.com", password: "password", password_confirmation: "password")
  end

  before(:each) do
    sign_in user
    @task = Task.create(title: 'Title test', user: user)
  end

  scenario 'should remove the post from index page' do
    visit tasks_path
    click_on 'Delete'
    expect(page).to have_content('Task successfully deleted')
    expect(page).not_to have_content('Title test')
  end
end
