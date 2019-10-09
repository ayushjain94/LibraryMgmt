Rails.application.routes.draw do
  resources :issues
  resources :bookmarks
  resources :book_audits
  resources :hold_requests
  resources :degree_to_book_mappings
  resources :belongs
  resources :libraries
  resources :books
  
  

  devise_for :admins, :skip => [:registrations], controllers: {sessions: 'admins/sessions', registrations: 'admins/registrations'}

  devise_for :librarians, controllers: {
      registrations: 'librarians/registrations',
      sessions: 'librarians/sessions'
  }
  resources :librarians

  devise_for :students, controllers: {
      registrations: 'students/registrations',
      sessions: 'students/sessions',
      omniauth_callbacks: 'students/omniauth_callbacks'
  }
  resources :students

  root :to => 'lms_home#index'

  post 'books/:id/check_out', to: 'books#check_out', :as => :books_check_out
  post 'books/:id/student_check_out', to: 'books#student_check_out', :as => :books_student_check_out
  get 'books/:id/admin_check_out', to: 'books#admin_check_out', :as => :books_admin_check_out
  post 'books/:id/bookmark', to: 'books#bookmark', :as => :books_bookmark
  post 'books/:id/bookmark_from_bm', to: 'books#unbookmark_from_bm', :as => :books_unbookmark_from_bm
  get 'admin_home/' => 'admin_home#index', :as => :admin_home
  get 'admin_home/showstudents' => 'admin_home#showstudents', :as => :showstudents_admin_home
  get 'admin_home/librarianapprovals' => 'admin_home#librarianapprovals', :as => :librarianapprovals_admin_home
  get 'admin_home/holdrequestapprovals' => 'admin_home#holdrequestapprovals', :as => :holdrequestapprovals_admin_home
  get 'librarian_home' => 'librarian_home#index', :as => :librarian_home
  get 'student_home' => 'student_home#index', :as => :student_home
  get 'approve_librarian/:id' => 'librarians#approve_librarian', :as => :approve_librarian
  get 'approve_holdrequest/:id' => 'hold_requests#approve_holdrequest', :as => :approve_holdrequest

  get 'student/:id/issues' => 'issues#get_issued_books', :as => :get_issued_books
  get 'book_audits/:id/show_history', to: 'book_audits#show_history', :as => :book_audits_show_history
  post 'books/:id/unbookmark', to: 'books#unbookmark', :as => :books_unbookmark
  post 'issues/:id/return', to: 'issues#return', :as => :issues_return
  get 'books/:id/update_to_lib', to: 'books#update_to_lib', :as => :update_to_lib
  get 'issues/:id/show_overdue', to: 'issues#show_overdue', :as => :show_overdue
  post 'books/:id/add_to_lib', to: 'books#add_to_lib', :as => :add_to_lib
  post 'books/:id/remove_from_lib', to: 'books#remove_from_lib', :as => :remove_from_lib
end