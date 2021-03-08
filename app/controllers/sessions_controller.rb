
class SessionsController < ApplicationController
    def omniauth
        binding.pry
        puts auth
        user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.username = auth['info']['first_name'] + auth['info']['last_name'][0].downcase 
            u.email= auth['info']['email']
            u.role= 0
            u.password_digest = SecureRandom.hex(16)
            u.picture= auth['info']['image']
            u.fname = auth['info']['first_name'].titleize 
            u.lname = auth['info']['last_name'].titleize

        end
        if user.valid?
            session[:user_id] = user.id
            redirect_to  :controller => 'user', :action => 'home'
        end
    end

    private
    def auth
        request.env['omniauth.auth']
    end

end
