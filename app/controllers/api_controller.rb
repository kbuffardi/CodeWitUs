class ApiController < ApplicationController
    protect_from_forgery with: :null_session

    def getInterest
        if request.post? 
            search= params[:search]

            @interestData = Interest.where("interest_name like ?","%#{search}%")
            render json: JSON.pretty_generate(@interestData.as_json)
        end
    
    end
end
