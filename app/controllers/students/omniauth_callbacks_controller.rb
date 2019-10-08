# frozen_string_literal: true

class Students::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  
  
  def facebook
    # You need to implement the method below in your model (e.g. app/models/student.rb)
    @student = Student.from_omniauth(request.env["omniauth.auth"])

    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/students/auth/facebook?auth_type=rerequest&scope=email"
      return # be sure to include an return if there is code after this otherwise it will be executed
    end

    if @student.persisted?
      sign_in_and_redirect @student, event: :authentication #this will throw if @student is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_student_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
  
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /students/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
