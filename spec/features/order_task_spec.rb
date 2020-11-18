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

  scenario 'should have a correct order on index page' do
    visit tasks_path
    expect(page).to have_content('First task test')
    expect(page).to have_content('Second task test')
    first_index = page.body.index('First task test')
    second_index = page.body.index('Second task test')
    expect(first_index).to be < second_index
  end

  scenario 'should change task order on index page when clicking on up' do
    visit tasks_path
    all('.up-btn')[1].find_link.click
    first_index = page.body.index('Second task test')
    second_index = page.body.index('First task test')
    expect(first_index).to be < second_index
  end

  scenario 'should change task order on index page when clicking on down' do
    visit tasks_path
    all('.down-btn')[0].find_link.click
    first_index = page.body.index('Second task test')
    second_index = page.body.index('First task test')
    expect(first_index).to be < second_index
  end
end
