class UserController < ApplicationController
    skip_before_action :verify_authenticity_token
    protect_from_forgery with: :null_session

    def register



        # @videos = Video.all
        params.permit(:name, :username, :email, :password)
        puts params.inspect
 
               
        if params[:email].blank? && params[:username].blank? && params[:password].blank? && params[:name].blank?
            redirect_to  :controller => 'user', :action => 'userError'
        
        elsif User.exists?(email: params[:email])
            
            redirect_to  :controller => 'user', :action => 'error'
        
        elsif(params[:password].length<12)
            redirect_to  :controller => 'user', :action => 'error'
        
        else
            user = User.find_or_create_by(email: params[:email], username: params[:username]) do |u|
                u.username = params[:username]
                u.email= params[:email]
                u.role= 0
                u.password_digest = BCrypt::Password.create(params[:password])
            end

            if user.valid?
                @userData = user
                session[:user_id] = user.id
                redirect_to  :controller => 'user', :action => 'home'
           
            end
        end
    end
    
    def userError
        flash[:error] = "Please fill the form."
        render template:'user/login'    
    end

    def error
        flash[:error] = "User already Exist"
        render template:'user/login'    
    end

    def login
        # @videos = Video.all
        
        if (session[:user_id] != nil)
            home
            return false
        end

        render template:'user/login'
    end

    def user_is_logged_in?
        !!session[:user_id]
    end

    def logout
        session.delete(:user_id)
        redirect_to  :controller => 'user', :action => 'login'
    end


    def home
        

        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        @user = session[:user_id] 
        @uData = User.find_by(id: @user )
        @interestData = Interest.order("interest_count DESC").limit(15)
        render template:'user/home'
        
    end
    
  

end
