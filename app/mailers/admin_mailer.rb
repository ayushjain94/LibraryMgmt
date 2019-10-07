class AdminMailer < Devise::Mailer
    default from: 'jn.ayush@gmail.com'
    layout 'mailer'

    def new_librarian_waiting_for_approval(email)
      @email = email
      mail(to: 'mitagavade@gmail.com', subject: 'New User Awaiting Admin Approval')
    end

    def book_checked_out(email, book)
      @email = email
      @book = book
      mail(to: @email, subject: "Book #{@book} has been successfully checked out")  
    end

end