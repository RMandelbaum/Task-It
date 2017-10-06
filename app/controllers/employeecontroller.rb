class EmployeeController < ApplicationController



        get '/employees' do

          erb :"employees/home"
        end

        get '/employees/signup' do
          @employers = Employer.all

          erb :"employees/signup"

        end

        post '/employees/signup' do

          @employer = Employer.all
          @employee = Employee.new(username: params[:username], email: params[:email], password: params[:password], employer_id: params[:employer_id])
        if @employee.save
           session[:user_id] = @employee.id



            redirect to "/employees/#{@employee.slug}"
        else
          redirect to '/employees/signup'
        end
      end

      get '/employees/login' do
         @employee = Employee.find_by(params[:employees])
         if is_logged_in? && current_user == @employee
           redirect "/employees/#{@employee.slug}"
         else
        erb :"employees/login"
       end

    end

    post '/employees/login' do
      @employee = Employee.find_by(username:params[:username])
      if @employee && @employee.authenticate(params[:password])
        session[:user_id] = @employee.id
        redirect "/employees/#{@employee.slug}"
      else
        redirect "/employees/login"
      end

  end

      get '/employees/:slug' do
        @employee = Employee.find_by_slug(params[:slug])
        @employer = Employer.find_by(params[:employer])
        @tasks = Task.all
        if is_logged_in?

        erb :"employees/tasks/show"

      else
        redirect '/employees'
      end
      end

  get '/employees/:slug/logout' do
      if is_logged_in?
        session.clear
        redirect '/'

    end

  end

end
