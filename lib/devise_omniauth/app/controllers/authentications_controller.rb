class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]

    current_user.authentications.
      find_or_create_by_provider_and_uid(omniauth['provider'],
                                         omniauth['uid'])
    flash[:notice] = "Authentication successful"
    redirect_to root_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to root_url
  end

end
