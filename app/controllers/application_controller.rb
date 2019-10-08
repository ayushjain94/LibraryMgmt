class ApplicationController < ActionController::Base
    before_action :get__loggedin_user

    def get__loggedin_user
        if admin_signed_in?
            user = 'admin'
        elsif librarian_signed_in?
            user = 'librarian'
        elsif student_signed_in?
            user = 'student'
        else
            user = nil
        end
        @current_user = user
    end

end
