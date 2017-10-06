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
           session[:user_id] = @employer.id

           redirect to "/employers/#{@employer.slug}/employees"
        else
          redirect to '/employers/signup'
        end
  end

  get '/employers/login' do
      @employer = Employer.find_by(params[:employer])
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
      if is_logged_in? && current_user.id == @employer.id
        session.clear
        redirect '/'
      end

  end

  get '/employers/:slug/employees' do
       if is_logged_in? #&& @employer.id == session[:user_id]
         @employer = Employer.find_by_slug(params[:slug])
         @employees = Employee.all
        erb :"employers/tasks/index"

      else
       redirect '/employers'
      end
   end

   get '/employers/:slug/employees/tasks' do

       @employer = Employer.find_by(params[:employer])
       @employee = Employee.find_by(employer_id: params[:employer_id])
       @task = Task.all

       erb :"employers/tasks/show"
   end

  get '/employers/:slug/employees/tasks/new' do
      @employee = Employee.find_by(params[:employee])
      @employer = Employer.find_by(params[:employer])

      #@task = Task.create(content: params[:content], employee_id: @employee.id)

      erb :"employers/tasks/new"
  end

  post '/employers/:slug/employees/tasks' do
      @employee = Employee.find_by(params[:employee])
      @employer = Employer.find_by(params[:employer])
      @task = Task.create(content: params[:content], employee_id: @employee.id)

      redirect '/employers/:slug/employees/tasks'

  end



  get '/employers/:slug/employees/tasks/:id' do
      @task = Task.find_by_id(params[:id])
      @employer = Employer.find_by(params[:employer])
      @employee = Employee.find_by(params[:employee])

      erb :"employers/tasks/edit"
  end

  patch '/employers/:slug/employees/tasks' do
      @task = Task.find_by(params[:task])
      @task.update(content: params[:content])
      @employer = Employer.find_by(params[:employer])
      @employee = Employee.find_by(params[:employee])

      redirect to "/employers/#{@employer.slug}/employees/tasks"
  end


  delete '/employers/:slug/employees/tasks/:id' do
      @task = Task.find_by_id(params[:id])
      @employer = Employer.find_by(params[:employer])
      @task.delete

      redirect to "/employers/#{@employer.slug}/employees/tasks"
  end

end
