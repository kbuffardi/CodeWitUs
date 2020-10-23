class ApiController < ApplicationController
    protect_from_forgery with: :null_session

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
                response = {:resp => "success"}
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
            interest_new = UserInterest.find_or_create_by(userId: session[:user_id], interestId: params[:val2]) do |u|
                u.userId = params[:val1]
                u.interestId= params[:val2]
            end
            
            response = {:resp => "success"}
            response.to_json
            render json: JSON.pretty_generate(response.as_json)               
        end
    end



end
