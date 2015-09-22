class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def create
    logger.info("Received create request")
    auth = request.env['omniauth.auth']

    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end

    if signed_in?
      if @identity.user == current_user
        logger.info("Already signed in with same identity")
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it 
        # is the current user. So the identity is already associated with 
        # this user. So let's display an error message.
        redirect_to root_url, notice: "Already linked that account!"
      else
        logger.info("Signed in with different identity")
        # The identity is not associated with the current_user so lets 
        # associate the identity
        @identity.user = current_user
        @identity.save()
        redirect_to root_url, notice: "Successfully linked that account!"
      end
    else
      logger.info("not signed in")
      if @identity.user.present?
        logger.info("User exists");
        # The identity we found had a user associated with it so let's 
        # just log them in here
        self.current_user = @identity.user
        redirect_to root_url
      else
        # No user associated with the identity so we need to create a new one
        @user = User.create_with_omniauth(auth[:info])
        @user.save!
        @identity.user = @user
        @identity.save!
        self.current_user = @user
        redirect_to new_church_path
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url
  end
end
