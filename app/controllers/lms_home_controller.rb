class LmsHomeController < ApplicationController
    def index
        if student_signed_in?
            render 'student_home/index'
        elsif librarian_signed_in?
            render 'librarian_home/index'
        elsif admin_signed_in?
            render 'admin_home/index'
        else
            render 'lms_home/index'
        end
    end
end
