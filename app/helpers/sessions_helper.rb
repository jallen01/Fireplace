module SessionsHelper

	def sign_in(user)
		# Make a token
    remember_token = User.new_remember_token
    # Place the unencryypted version
    cookies.permanent[:remember_token] = remember_token
    # Encrypt and put it in the database
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # Set user = current one
    self.current_user = user
  end

  def current_user=(user)
  	@current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    #Now we can look up by token!
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  # Is someone signed in?
  def signed_in?
    !current_user.nil?
  end

  def sign_out
    # No one is signed in
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  # redirect to root if signed in
  def redirect_if_signed_in
    if signed_in?
      redirect_to root_url
    end
  end

end