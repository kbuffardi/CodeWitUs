class ApplicationController < ActionController::Base
    

    def home
        @interestData = Interest.all().limit(8)
        render template:'static/index'
    end

 
    
end
