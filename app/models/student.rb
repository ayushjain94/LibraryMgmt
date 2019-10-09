class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  validates :university, :name, presence: true
  def self.new_with_session(params, session)
    super.tap do |student|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        student.email = data["email"] if student.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |student|
    student.email = auth.info.email
    student.password = Devise.friendly_token[0, 20]
    student.name = auth.info.name   # assuming the student model has a name
    student.university = 'NCSU'
    student.degree_to_book_mappings_id = 1
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # student.skip_confirmation!
  end

  


  end
end
