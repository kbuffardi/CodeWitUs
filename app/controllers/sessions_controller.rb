
class SessionsController < ApplicationController
    def omniauth
        # binding.pry
        user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.username = auth['info']['first_name']
            u.email= auth['info']['email']
            u.role= 0
            u.password_digest = SecureRandom.hex(16)
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
