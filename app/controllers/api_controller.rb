class ApiController < ApplicationController
    def getInterest
        if request.get? 
            search= params[:search]

            @interestData = Interest.where("interest_name like ?","%#{search}%")
            render json: JSON.pretty_generate(@interestData.as_json)
        end
    
    end
end
