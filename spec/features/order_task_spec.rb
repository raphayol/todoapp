# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order a Task', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(email: 'test@user.com', password: 'password', password_confirmation: 'password')
  end

  before(:each) do
    sign_in user
    Task.create(title: 'First task test', user: user)
    Task.create(title: 'Second task test', user: user)
  end

  scenario 'should change task order on index page' do
    visit tasks_path
    click_on 'up'

    # TODO: Find a way to check task order on the page

  end
end
