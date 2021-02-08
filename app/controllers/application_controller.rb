class ApplicationController < ActionController::Base
    

    def home
        @interestData = Interest.all().limit(5)
        @conceptsData = Concept.all.limit(5)
        render template:'static/index'
    end

 
    
end
