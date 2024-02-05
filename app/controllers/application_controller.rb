class ApplicationController < ActionController::Base

    private

    def authenticate_user!
      redirect_to root_path, alert: "You must be logged in to do that." unless user_signed_in?
    end

    def current_user
        Current.user ||= authenticate_user_from_session
    end
    helper_method :current_user

    def authenticate_user_from_session
      user_id = session[:user_id]
      User.find_by(id: user_id) if user_id.present? && User.exists?(user_id)
    end

    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?

    def login(user)
        Current.user = user
        reset_session
        if user.present?
          session[:user_id] = user.id
        else
          Rails.logger.error("User is nil in login method")
        end
    end

    def logout(user)
      Current.user = nil
      reset_session
    end
end
