module SessionsHelper
    def log_in(user)
        session[:id]=user.id
    end
end
