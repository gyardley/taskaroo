# app/controllers/callbacks_controller.rb

class CallbacksController < Devise::OmniauthCallbacksController

  def twitter

    # Retrieve existing or create a new user.
    @valid_user = User.retrieve_or_create(request.env['omniauth.auth'])

    if @valid_user # Check to see if this is a valid user.
      flash[:notice] = "You successfully signed in with Twtiter." # Show success message.
      sign_in_and_redirect @valid_user # Log the user in and redirect to success location.
    else
      flash[:error] = "You were not able to sign in with Twitter." # Show failure message.
      redirect_to root_path
    end

  end

end
