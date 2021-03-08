class ApplicationController < ActionController::Base
    

    def home

        if params[:interest] 
            @intrID = params[:interest]
            puts @intrID
        
            @interestData = Interest.all()
            @videoMain = Video.where(:interests => @intrID).all().order('RANDOM()');

            if params[:concept] 
                @conID = params[:concept] 
                @videoData = Video.where(:interests => @intrID , :concepts => @conID).all().order('RANDOM()');
                @uvInterest = Interest.find_by_sql([ "SELECT * FROM interests JOIN videos ON interests.id = CAST(videos.interests AS INTEGER) AND CAST(videos.interests AS INTEGER) = ? AND CAST(videos.concepts AS INTEGER) = ?", @intrID, @conID]);
                @uvConcepts = Concept.find_by_sql([ "SELECT * FROM concepts JOIN videos ON concepts.id = CAST(videos.concepts AS INTEGER) AND CAST(videos.interests AS INTEGER) = ? AND CAST(videos.concepts AS INTEGER) = ?", @intrID, @conID]);
                @uvCreators = User.find_by_sql([ "SELECT * FROM users JOIN videos ON users.id = CAST(videos.user AS INTEGER) AND CAST(videos.interests AS INTEGER) = ? AND CAST(videos.concepts AS INTEGER) = ?", @intrID, @conID]);

            else
                @videoData = Video.where(:interests => @intrID).all().order('RANDOM()');
                @uvInterest = Interest.find_by_sql([ "SELECT * FROM interests JOIN videos ON interests.id = CAST(videos.interests AS INTEGER) AND CAST(videos.interests AS INTEGER) = ?", @intrID]);
                @uvConcepts = Concept.find_by_sql([ "SELECT * FROM concepts JOIN videos ON concepts.id = CAST(videos.concepts AS INTEGER) AND CAST(videos.interests AS INTEGER) = ?", @intrID]);
                @uvCreators = User.find_by_sql([ "SELECT * FROM users JOIN videos ON users.id = CAST(videos.user AS INTEGER) AND CAST(videos.interests AS INTEGER) = ?", @intrID]);
           
            end 

            if @videoData.present?

                # Getting the Concept ID from Videos
                @order = []
                @videoMain.each do |item|
                    @order.push( item.concepts )
                end

                @conceptsData = Concept.find(@order)
                puts @conceptsData
                @videoInt = Interest.find_by(id: @videoData[0].interests)
                @videoCon = Concept.find_by(id: @videoData[0].concepts)
                @videoAut = User.find_by(id: @videoData[0].user)

                
                

            else
                @interestData = Interest.all()
                @conceptsData = []
                @videoData = Video.order('RANDOM()').limit(1);
                @videoInt = Interest.find_by(id: @videoData[0].interests)
                @videoCon = Concept.find_by(id: @videoData[0].concepts)
                @videoAut = User.find_by(id: @videoData[0].user)
            end
        else
            @interestData = Interest.all()
            @conceptsData = []
            @videoData = Video.order('RANDOM()').limit(1);
            @videoInt = Interest.find_by(id: @videoData[0].interests)
            @videoCon = Concept.find_by(id: @videoData[0].concepts)
            @videoAut = User.find_by(id: @videoData[0].user)
        end
        


        if session[:user_id] == nil
            @headerFlag = 0
        end



        render template:'static/index'
    end

 
    
end
