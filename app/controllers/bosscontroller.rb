class BossController < ApplicationController


      get '/boss' do

        erb :"boss/home"
      end

      get '/boss/signup' do

        erb :"boss/signup"

        redirect to "/boss/#{@boss.slug}"
      end

      post '/boss' do

        erb :"boss/index"

      end


end
