class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions

  get '/' do

    erb :home
  end

  get '/signup' do
    #make it so they can only check one option
    erb :signup

  end

  post '/signup' do
     if params[:employee]
       @worker = Worker.new(username: params[:username], email: params[:email], password: params[:password])
        if @worker.save
         session[:worker_id] = @worker.id
         redirect "/tasks/#{@worker.slug}"
        end
     elsif params[:employer]
      @boss = Boss.new(username: params[:username], email: params[:email], password: params[:password])
         if @boss.save
          session[:boss_id] = @boss.id
          redirect "/#{@boss.slug}/employees"
         end
    else
        redirect '/signup'
    end
end

  get '/login' do
    @boss = Boss.find(session[:boss_id])
    @worker = Worker.find_by(session[:worker_id])
    if is_logged_in? && @boss
      redirect "/#{@boss.slug}/employees"
    elsif is_logged_in? && @worker
      redirect "tasks/#{@worker.slug}"
    else
      erb :"/login"
    end
  end


#
#   post '/boss/login' do
#     @boss = Boss.find_by(username:params[:username])
#     if @boss && @boss.authenticate(params[:password])
#       session[:user_id] = @boss.id
#       redirect "/boss/#{@boss.slug}"
#     else
#       redirect "/boss/login"
#     end
  post '/login' do

  end

  def current_user
    @boss = Boss.find_by_id(session[:user_id])
  end

  def is_logged_in?
    !!session[:user_id]
  end

end
