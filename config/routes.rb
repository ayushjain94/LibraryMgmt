Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations' }

  devise_for :librarians, controllers: {
        registrations: 'librarians/registrations',
        sessions: 'librarians/sessions'
  }


  devise_for :students, controllers: {
        registrations: 'students/registrations',
        sessions: 'students/sessions'
  }

  post 'books/:id/check_out', to: 'books#check_out', :as => :books_check
  post 'books/:id/bookmark', to: 'books#bookmark', :as => :books_bookmark
  get 'admin_home/' => 'admin_home#index', :as => :admin_home
  get 'admin_home/showstudents' => 'admin_home#showstudents', :as => :showstudents_admin_home
  get 'admin_home/librarianapprovals' => 'admin_home#librarianapprovals', :as => :librarianapprovals_admin_home
  get 'librarian_home' => 'librarian_home#index', :as => :librarian_home
  get 'student_home' => 'student_home#index', :as => :student_home
  get 'approve_librarian/:id' => 'librarians#approve_librarian', :as => :approve_librarian
  root :to => "student_home#index"

  resources :book_audits
  resources :books
  resources :libraries
  resources :students
  resources :issues
  resources :bookmarks
  resources :degree_to_book_mappings
  resources :hold_requests
  resources :librarians
  resources :admins

  # get '/search' => 'books#search', :as => 'search_page'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
