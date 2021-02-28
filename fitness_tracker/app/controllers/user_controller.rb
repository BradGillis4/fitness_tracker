require 'pry'
class UserController < ApplicationController
    get '/signup' do #shows form
        erb :"user/signup"
    end

    post '/signup' do #accepts user data
        
        @user = User.new(params) #not an instance, because its not on a view. Instance variables share info from controller to view
        @user.save(validate: false)
        if @user.save(validate: false)
            redirect "/login"
          else
            redirect "/failure"
          end
        
        # if User.find_by_email(params[:email]) || User.find_by_username(params[:username])
        #     # user.username.blank? || user.email.blank? || user.password.blank? || 
        #     flash[:error] = "Invalid Signup"
        #     redirect '/'
            
        # else 
        #     user.save(validate:false)
        #     session[:user_id] = user.id # logging user in
        #     redirect '/posts'
        # end 


    end

    get '/login' do 
        erb :"user/login"
    end

    post '/login' do
        user=User.find_by_username(params[:username]) #:username is defined in name="" in login.erb
        # binding.pry

        if user && user.authenticate(params[:password])
            # login user
            session[:user_id] = user.id
            # redirect 
            redirect '/posts'
        else
            flash[:error] = "Invalid Login"
            redirect '/login'
        end
    end

    get '/logout' do 
        session.clear
        redirect '/'
    end

end