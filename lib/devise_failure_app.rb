# If User not signed in, want to redirect to sign_up (not sign_in)
# https://github.com/plataformatec/devise/wiki/Redirect-to-new-registration-(sign-up)-path-if-unauthenticated
class DeviseFailureApp < Devise::FailureApp
  def route(scope)
    :new_user_registration_url
  end
end
