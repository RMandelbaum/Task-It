class EmployerController < ApplicationController



    get '/boss' do

      erb :"boss/home"
    end

    get '/boss/signup' do
      @boss = Boss.all

      erb :"boss/signup"

    end



    post '/boss/signup' do
      @boss = Boss.new(username: params[:username], email: params[:email], password: params[:password])
      if @boss.save
        session[:user_id] = @boss.id
        redirect to "/boss/#{@boss.slug}"
    else
      redirect to '/boss/signup'
    end
  end

  get '/boss/login' do
     @boss = Boss.find_by(session[:user_id])
     if is_logged_in?
       redirect "/boss/#{@boss.slug}"
     else
    erb :"boss/login"
   end

end

post '/boss/login' do
  @boss = Boss.find_by(username:params[:username])
  if @boss && @boss.authenticate(params[:password])
    session[:user_id] = @boss.id
    redirect "/boss/#{@boss.slug}"
  else
    redirect "/boss/login"
  end

end




  get '/boss/:slug' do
    if is_logged_in? #current_user.id = @boss.id
    @boss = Boss.find_by_slug(params[:slug])
    @worker = Worker.all



    erb :"boss/index"

  else
    redirect '/boss'
  end
  end
  get '/boss/:slug/logout' do
      if is_logged_in?
        session[:user_id] = {}
        redirect '/'

    end

  end
end
