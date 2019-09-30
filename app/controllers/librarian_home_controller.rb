class LibrarianHomeController < ApplicationController
    before_action :authenticate_librarian!
    def index
        render 'librarian_home/index'
    end
end
