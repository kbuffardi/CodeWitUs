class VideoController < ApplicationController

    skip_before_action :verify_authenticity_token

    
    def new
        @videos = Video.new
        @videoss = Video.all

    end

    def index

        if session[:user_id] == nil
            render template:'user/login'
            return false
        end
        
        # @videos = Video.all
        @user = session[:user_id] 
        @uData = User.find_by(id: @user )
        render template:'video/index'
    end



    def home


        if session[:user_id] == nil
            render template:'user/login'
            return false
        end
        
        if params[:id] 
            @vid = params[:id] 
            @user = session[:user_id] 
            @uData = User.find_by(id: @user )
            @vData = Video.find_by(id: @vid )
            
            
            if Like.exists?(video_id: @vid, user_id:@user )
                @likeVal = 1
            else
                @likeVal = 0
            end
            
            if Interest.exists?(id: @vData.interests)
                @interest = Interest.find_by(id: @vData.interests )
                @int = @interest.interest_name
            else
                @int = "Interest"
            end

            if Concept.exists?(id: @vData.concepts)
                @concept = Concept.find_by(id: @vData.concepts)
                @con = @concept.name
            else
                @con = "Concept"
            end

            render template:'video/index'
        else
            # @videos = Video.all
            @user = session[:user_id] 
            @uData = User.find_by(id: @user )
            render template:'video/index'
        end
    end

  
    
    
    def create
        @videos = Video.new(my_params)
        if @videos.save
            render json: @videos
        else
            render :new
        end

    end

    private
    def my_params
        params.require(:videos).permit(:user,:video_id)
    end
end
