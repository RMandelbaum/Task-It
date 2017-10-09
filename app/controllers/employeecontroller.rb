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

               redirect to "/employees/#{@employee.slug}/tasks"
            else
               redirect to '/employees/signup'
            end
        end

         get '/employees/login' do
            @employee = Employee.find_by(params[:employees])
            if is_logged_in? && @employee.id == session[:user_id]

               redirect "/employees/#{current_user.slug}/tasks"
            else

              erb :"employees/login"
           end
        end

         post '/employees/login' do
            @employee = Employee.find_by(username:params[:username])
             if @employee && @employee.authenticate(params[:password])
               session[:user_id] = @employee.id
               redirect "/employees/#{@employee.slug}/tasks"
             else
               redirect "/employees/login"
             end
           end

        get '/employees/:slug/logout' do
              if is_logged_in? && current_user.id == @employee.id
                 session.clear
                 redirect '/'
             end
           end

        get '/employees/:slug/tasks' do
           @employee = Employee.find_by_slug(params[:slug])
           @tasks = @employee.tasks
           if is_logged_in? && @employee.id == session[:user_id]

              erb :"employees/tasks/edit"
          else

            redirect '/employees/login'
          end
        end


        delete '/employees/:slug/tasks/:id' do
            @employee = current_user
            @task = Task.find_by_id(params[:id])
            params[:content]
            @task.delete

            redirect "/employees/#{@employee.slug}/tasks"

         end

end
