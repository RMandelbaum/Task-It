class TaskController < ApplicationController


    get 'workers/:slug/tasks' do
        erb :"workers/show"
      end
end
