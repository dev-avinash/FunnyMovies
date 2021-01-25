# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :validate_params, only: :create

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_or_initialize_by(email: params[:user][:email])

    if user.new_record?
      user.password = params[:user][:password]
      return redirect_to root_url, notice: t('session.user_creation_error', error: user.errors.full_messages.to_sentence) unless user.save
    end
    self.resource = warden.authenticate(auth_options)

    if self.resource
      set_flash_message(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      redirect_to root_path, notice: t('session.logged_in')
    else
      redirect_to root_path, notice: t('session.invalid_email_or_pwd')    
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  private

  def validate_params
    return redirect_to root_url, notice: t('session.empty_required_fields') unless required_params_present?
  end

  def required_params_present?
    params[:user][:email].present? && params[:user][:password].present?
  end
end
