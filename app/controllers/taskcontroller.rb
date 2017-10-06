class TaskController < ApplicationController


     get '/tasks/:slug' do
        @tasks = Task.all
        @worker = Worker.find_by_slug(params[:slug])

        erb :"tasks/show"
      end

      get '/tasks/:slug/new' do
        @worker = Worker.find_by_slug(params[:slug])


        erb :"tasks/new"
      end

      post '/tasks/:slug' do
        @tasks = Task.create(content: params[:content])
      end

      get '/tasks/:slug/edit' do

        erb :"tasks/edit"
      end

      patch '/tasks/:slug' do

      end

      get '/tasks/:slug/:id' do
    end

    get '/tasks/:slug/:id/edit' do
    end

      delete '/tasks/:slug/:id/delete' do

      end
end
