# app/controllers/callbacks_controller.rb

class CallbacksController < Devise::OmniauthCallbacksController

  def twitter
    logger.info "Start of 'twitter' method."
    # Get valid user.
    auth_hash = request.env['omniauth.auth']
    logger.info "After auth_hash."
    @valid_user = User.retrieve_or_create(auth_hash)
    logger.info "After valid_user"

    if @valid_user # Check to see if this is a valid user.
      flash[:notice] = "You successfully signed in to Twtiter." # Show success message.
      sign_in_and_redirect @valid_user # Log the user in and redirect to success location.
    else
      flash[:error] = "You were not able to sign in to Twitter." # Show failure message.
      redirect_to root_path
    end

  end

end
