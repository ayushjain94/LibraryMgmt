class AdminHomeController < ApplicationController
  before_action :authenticate_admin!
  def index
    
  end

  def showstudents
    @show_students = Student.where(is_active: nil)
  end

  def librarianapprovals
    @pending_librarians = Librarian.where(approved: nil)
  end

end
