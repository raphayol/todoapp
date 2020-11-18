# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/tasks', to: 'tasks#index'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create', as: 'task'
  delete '/tasks', to: 'tasks#destroy', as: 'destroy_task'

  root 'tasks#index'
end
