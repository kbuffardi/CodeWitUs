class VideoController < ApplicationController

   
    
    def new
        @videos = Video.new
        @videoss = Video.all

    end

    def index
        # @videos = Video.all
        render template:'video/index'
    end

    def home
        # @videos = Video.all
        render template:'video/index'
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
