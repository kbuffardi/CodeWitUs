class UserController < ApplicationController
    skip_before_action :verify_authenticity_token

    def register
        # @videos = Video.all
        params.permit(:name, :username, :email, :password)
        puts params.inspect

        if User.exists?(email: params[:email])
            redirect_to  :controller => 'user', :action => 'login'
        
        else
            user = User.find_or_create_by(email: params[:email], username: params[:username]) do |u|
                u.username = params[:username]
                u.email= params[:email]
                u.role= 0
                u.password_digest = params[:password]
            end
            if user.valid?
                session[:user_id] = user.id
                redirect_to  :controller => 'user', :action => 'home'
            end
        end
    end
    
    def login
        # @videos = Video.all
        render template:'user/login'
    end
    def home
        render template:'user/home'
    end
end
