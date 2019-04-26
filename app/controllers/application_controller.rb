class ApplicationController < ActionController::Base
  before_action   :define_access

  def define_access
    if user_signed_in?
      @editor_access = current_user.has_roles?(:admin, :editor) ? true : false
      @admin_access = current_user.has_roles?(:admin) ? true : false
    end
  end
end
