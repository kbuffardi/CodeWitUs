class ManageController < ApplicationController

    def home
        
        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        @user = session[:user_id] 
        @uData = User.find_by(id: @user )

        if @uData.role == 1
            render template:'manage/home'
        else
            url = "/home"
            redirect_to url    
        end
        
    end




end
