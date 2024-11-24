class Users::SessionsController < Devise::SessionsController
    # Override the destroy action to log out users
    def destroy
      super # This calls the default Devise sign_out logic
      # You can add custom logic here, like redirecting to a specific page
      redirect_to root_path, notice: 'You have successfully logged out.'
    end
  end
  