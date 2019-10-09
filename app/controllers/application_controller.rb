class ApplicationController < ActionController::Base
    before_action :get__loggedin_user
    def get__loggedin_user
        if admin_signed_in?
            user = 'admin'
            sign_out current_student if student_signed_in? 
            sign_out current_librarian if librarian_signed_in? 
        elsif librarian_signed_in?
            user = 'librarian'
            sign_out current_admin if admin_signed_in? 
            sign_out current_student if student_signed_in? 
        elsif student_signed_in?
            user = 'student'
            sign_out current_admin if admin_signed_in? 
            sign_out current_librarian if librarian_signed_in? 
        else
            user = nil
        end
        @current_user = user
    end
end
