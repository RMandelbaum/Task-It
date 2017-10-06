class EmployeeController < ApplicationController



        get '/workers' do

          erb :"workers/home"
        end

        get '/workers/signup' do
          @workers = Worker.all

          erb :"workers/signup"

        end

        post '/workers/signup' do
          @worker = Worker.new(username: params[:username], email: params[:email], password: params[:password])
          if @worker.save
            session[:user_id] = @worker.id
            redirect to "/workers/#{@worker.slug}"
        else
          redirect to '/workers/signup'
        end
      end

      get '/workers/login' do
         @worker = Worker.find(session[:user_id])
         if is_logged_in?
           redirect "/workers/#{@worker.slug}"
         else
        erb :"workers/login"
       end

    end

    post '/workers/login' do
      @worker = Worker.find_by(username:params[:username])
      if @worker && @worker.authenticate(params[:password])
        session[:user_id] = @worker.id
        redirect "/workers/#{@worker.slug}"
      else
        redirect "/workers/login"
      end

  end

      get '/workers/:slug' do
        @worker = Worker.find_by_slug(params[:slug])
        @tasks = Task.all
        if is_logged_in? #current_user.id = @boss.id

        erb :"tasks/show"

      else
        redirect '/workers'
      end
      end

  get '/workers/:slug/logout' do
      if is_logged_in?
        session[:user_id] = {}
        redirect '/'

    end

  end

end
