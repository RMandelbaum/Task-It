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

        redirect to "/employers/#{@employer.slug}"
    else
      redirect to '/employers/signup'
    end
  end

  get '/employers/login' do
     @employer = Employer.find_by(params[:employer])
     if is_logged_in?
       redirect "/employers/#{@employer.slug}"
     else
    erb :"employers/login"
   end

end

post '/employers/login' do
  @employer = Employer.find_by(params[:employer])
  if @employer && @employer.authenticate(params[:password])
    session[:user_id] = @employer.id
    redirect "/employers/#{@employer.slug}"
  else
    redirect "/employers/login"
  end

end




  get '/employers/:slug' do
    if is_logged_in? #current_user.id = @employer.id
    @employer = Employer.find_by_slug(params[:slug])
    @employee = Employee.all



    erb :"employers/index"

  else
    redirect '/employers'
  end
  end


  get '/employers/:slug/logout' do
      if is_logged_in?
        session.clear
        redirect '/'

    end

  end
end
