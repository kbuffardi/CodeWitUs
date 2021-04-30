class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    # Get all Interest from DB

    def getInterest
        if request.post? 
            search= params[:keyword]

            @interestData = Interest.where("interest_name like ?","%#{search}%").limit(5)
            render json: JSON.pretty_generate(@interestData.as_json)
        end
    
    end


    # Create New Interest 

    def newInterest

        if request.post? 
            search= params[:keyword]

            if Interest.exists?(interest_name: search)
                response = {:resp => "failed"}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)
            else    
                newIntr = Interest.find_or_create_by(interest_name: search)
                response = {:resp => newIntr.id}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)            
            end
       
        end
    
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
      


    def newVideo

        if request.post? 
            search= params[:keyword]
            userId = session[:user_id]

            if Video.exists?(video_id: search)
                response = {:resp => "failed"}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)
            else   
                 
                newIntr = Video.find_or_create_by(user:userId,video_id:youtube_embed(search)
                )
                response = {:resp => newIntr.id}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)            
            end
       
        end
    
    end

    def clearInterest
        if request.post? 
            id= params[:keyword]
            UserInterest.delete_by(userId: session[:user_id] );

            response = {:resp => "success"}
            response.to_json
            render json: JSON.pretty_generate(response.as_json)               
        end
    end


    def insertInterest
        if request.post? 
            interest_new = UserInterest.find_or_create_by(userId: session[:user_id], interestid: params[:val2]) do |u|
                u.userId = session[:user_id]
                u.interestid= params[:val2]
            end
            
            response = {:resp => "success"}
            response.to_json
            render json: JSON.pretty_generate(response.as_json)               
        end
    end

    def insertConcept
        if request.post? 

            if Concept.exists?( name: params[:keyword])
                response = {:resp => "failed"}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)
            else    
                newIntr = Concept.find_or_create_by(name: params[:keyword])
                response = {:resp => newIntr.id}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)            
            end            
        end
    end

    def like
       
        if request.post? 
            search = params[:keyword]
            userId = session[:user_id]

            if Like.exists?(video_id: search, user_id:userId )
                Like.delete_by(video_id: search, user_id:userId)
                response = {:resp => "Deleted"}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)
            else    
                newIntr = Like.find_or_create_by(video_id: search, user_id:userId)
                response = {:resp => newIntr.id}
                response.to_json
                render json: JSON.pretty_generate(response.as_json)            
            end
       
        end
    end

    def getUser

        if request.post? 
            search= params[:keyword]

            @userData = User.where("email like ?","%#{search}%").limit(10)
            render json: JSON.pretty_generate(@userData.as_json)
        end

    end


    def accessUser

        if request.post? 
            key1 = params[:uid]
            key2 = params[:role]

            user = User.find(key1)
            user.role = key2
            user.save


            render json: JSON.pretty_generate({:resp => "Success"});
        end

    end


    def newAlert

        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        if request.post? 
            msg= params[:message]
            expiry= params[:expiry]

            newIntr = AlertMessage.find_or_create_by(message: msg, user: session[:user_id], expiry: expiry)
            response = {:resp => newIntr.id}
            response.to_json
            url = "/creator/alert"
            redirect_to url        
        end
    
    end



    def editAlert

        if session[:user_id] == nil
            render template:'user/login'
            return false
        end

        if request.post? 
            msg= params[:message]
            expiry= params[:expiry]
            id = params[:id]
         
            alert = AlertMessage.find(id)
            alert.message = msg
            alert.expiry = expiry
            alert.save

            url = "/creator/alert"
            redirect_to url        
        end
    
    end


end
