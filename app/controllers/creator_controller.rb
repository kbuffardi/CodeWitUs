class CreatorController < ApplicationController

    skip_before_action :verify_authenticity_token
    protect_from_forgery with: :null_session
    
    def add
        
        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        @user = session[:user_id] 
        @uData = User.find_by(id: @user )
        @interestData = Interest.order("interest_count DESC").limit(15)
        @conceptData = Concept.order("id DESC").limit(15)

        if @uData.role == 1
            render template:'creator/add'
        else
            url = "/home"
            redirect_to url    
        end
        
    end


    def alert
        
        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        @user = session[:user_id] 
        @date = Date.today.to_datetime
        @uData = User.find_by(id: @user )
        @activeAlerts = AlertMessage.where('expiry > ?', @date).all

        puts @activeAlerts

        if @uData.role == 1
            render template:'creator/alert'
        else
            url = "/home"
            redirect_to url    
        end
        
    end


    def editalert
        
        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        if params[:alertId] 
            @alertId = params[:alertId] 
            @user = session[:user_id] 
            @date = Date.today.to_datetime
            @uData = User.find_by(id: @user )
            @activeAlerts = AlertMessage.where(:id => @alertId).limit(1)

            @todo = @activeAlerts[0].expiry.strftime('%Y-%m-%dT%H:%M')

            puts @activeAlerts

            if @uData.role == 1
                render template:'creator/editAlert'
            else
                url = "/home"
                redirect_to url    
            end
        else
            url = "/home"
            redirect_to url    
        end
       
        
    end




    def profile
        

           
        if session[:user_id] == nil
            render template:'user/login'
            return false
        end


        @user = params[:userid]
        
        @uData = User.find_by(username: @user)

        if @uData.role != 1
            url = "/home"
            redirect_to url    
            return false
        end


        @uInterest = UserInterest.where(userId: @uData.id).all
        @uInterest = Interest.find_by_sql([ "SELECT * FROM interests JOIN user_interests ON interests.id =  user_interests.interestId AND user_interests.userid = ?", @uData.id]);
        @uVideo  = Video.where(user: @uData.id).all
        
        @uvInterest = Interest.find_by_sql([ "SELECT * FROM interests JOIN videos ON interests.id = CAST(videos.interests AS INTEGER)"]);
        @uvConcepts = Concept.find_by_sql([ "SELECT * FROM concepts JOIN videos ON concepts.id = CAST(videos.concepts AS INTEGER)"]);


        puts @uIntData

        render template:'creator/profile'
        
    end
    



    def youtube_embed(youtube_url)
        if youtube_url[/youtu\.be\/([^\?]*)/]
          youtube_id = $1
        else
          # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
          youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
          youtube_id = $5
        end
      
        %Q{#{ youtube_id }}
    end


    def addTutorial
        if request.post? 

            puts params


            if session[:user_id] == nil
                render template:'user/login'
                return false
            end

            @user = session[:user_id] 
            @uData = User.find_by(id: @user )

            if request.post? 
                title= params[:title]
                ytlink= params[:ytlink]
                concepts= params[:concepts]
                interest= params[:interest]
                cwlink= params[:cwlink]
                userId = session[:user_id]
    
                if Video.exists?(video_id: ytlink)
                    response = {:resp => "failed"}
                    response.to_json
                    render json: JSON.pretty_generate(response.as_json)
                else   
                     
                    newIntr = Video.find_or_create_by(user:userId,video_id:youtube_embed(ytlink), vtitle: title, concepts:concepts, interests:interest, cwlink:cwlink
                    )

                    add
                    return true       
                end

           
            end

            
        end

    end
end
