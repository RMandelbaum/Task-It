class EmployerController < ApplicationController

  get '/employers' do

      erb :"employers/home"
  end

  get '/employers/signup' do
      @employer = Employer.all

      erb :"employers/signup"
  end

  post '/employers/signup' do
      @employer = Employer.new(username: params[:username], email: params[:email], password: params[:password])
        if @employer.save
          current_user = @employer
           session[:user_id] = @employer.id
           redirect to "/employers/#{@employer.slug}/employees"
        else
          redirect to '/employers/signup'
        end
  end

  get '/employers/login' do
        if is_logged_in?
          redirect "/employers/#{@employer.slug}/employees"
        else
          erb :"employers/login"
        end

  end

  post '/employers/login' do

         @employer = Employer.find_by(username: params[:username])
         if @employer && @employer.authenticate(params[:password])
            session[:user_id] = @employer.id
            redirect "/employers/#{@employer.slug}/employees"
         else
            redirect "/employers/login"
         end

   end


  get '/employers/:slug/logout' do
      if is_logged_in?
        session.clear
        redirect '/'
      end

  end

  get '/employers/:slug/employees' do
       @employer = Employer.find_by_slug(params[:slug])

        if is_logged_in? && @employer.id == session[:user_id]
         @employees = Employee.all
        erb :"employers/tasks/index"

      else
       redirect '/employers'
      end
   end

   get '/employers/:slug/employees/:username/tasks' do

       @employer = Employer.find_by_slug(params[:slug])
       @employee = Employee.find_by(username: params[:username])
       @task = @employee.tasks

       erb :"employers/tasks/show"
   end

  get '/employers/:slug/employees/:username/tasks/new' do
      @employee = Employee.find_by(username: params[:username])
      @employer = Employer.find_by_slug(params[:slug])

      erb :"employers/tasks/new"
  end

  post '/employers/:slug/employees/:username/tasks' do
      @employee = Employee.find_by(username: params[:username])
      @employer = Employer.find_by_slug(params[:slug])
      @task = Task.new(content: params[:content], employee_id: @employee.id)
      if @task.employee_id == @employee.id
        @task.save
      end
      redirect "/employers/#{@employer.slug}/employees/#{@employee.username}/tasks"

  end



  get '/employers/:slug/employees/:username/tasks/:id' do
      @task = Task.find_by_id(params[:id])
      @employer = Employer.find_by_slug(params[:slug])
      @employee = Employee.find_by(username: params[:username])

      erb :"employers/tasks/edit"
  end

  patch '/employers/:slug/employees/:username/tasks' do
      @employer = Employer.find_by_slug(params[:slug])
      @employee = Employee.find_by(username: params[:username])
      @task = Task.find_by(params[:id])
      if params[:content].empty?
        redirect to "/employers/#{@employer.slug}/employees/#{@employee.username}/tasks/#{@task.id}"
      else
      @task.update(content: params[:content])

      redirect to "/employers/#{@employer.slug}/employees/#{@employee.username}/tasks"
  end
end


  delete '/employers/:slug/employees/:username/tasks/:id' do
      @employer = Employer.find_by_slug(params[:slug])
      @employee = Employee.find_by(username: params[:username])
      @task = Task.find_by_id(params[:id])

      @task.delete

      redirect to "/employers/#{@employer.slug}/employees/#{@employee.username}/tasks"
  end
end
