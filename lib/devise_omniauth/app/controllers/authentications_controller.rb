class AuthenticationsController < ApplicationController
  #
  # create
  #
  # authenticate a returning user or create a
  # new authenticationfor an existing user
  def create
    # store authentication has from 3rd party web service
    omniauth = request.env["omniauth.auth"]
    # try to find an existing authentication in the db
    authentication = Authentication.
      find_by_provider_and_uid(omniauth['provider'],
                               omniauth['uid'])
    #
    # handle flowing cases: 
    #                       
    #     * returning user
    #     * new authentication for existing user
    #     * new user
    #
    if authentication
      # we found an authentication in the db so
      # we know this is a returning user
      flash[:notice] = "Signed in successfully"
      # sign in and redirect user
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      # We did not find a matching authentication in the
      # database but current_user is defined. This tells
      # us that a currently logged in user is adding a new
      # authentication method to their existing account.

      # build new authentication for current_user
      current_user.build_authentication(omniauth)
      current_user.save!

      flash[:notice] = "Authentication successful"
      redirect_to root_url
    else
      # We did not find a matching authentication and there
      # is no current_user. So, we need to create a new User
      # and a new Authentication.       

      # new user
      user = User.new
      # Build a new authentication
      user.build_authentication(omniauth)
      # try to save the user
      if user.save
        # if we pass the authentications redirect the new user
        # to the user's profile page
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        # if we did not pass the authentications (e.g. the new
        # user did not have an email address) we redirect to 
        # the new_user_registration_url so that the new user
        # can give us the information that we need. This is where
        # we collect emails from people who sign up with LinkedIn or 
        # Facebook.
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end # create

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to root_url
  end

end
