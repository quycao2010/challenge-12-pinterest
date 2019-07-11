class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login(user)
      redirect_to root_path
    else
      redirect_to login_path, notice: "Your user or password is wrong"
    end
  end
  
  def destroy
    logout
    redirect_to root_path
  end
  
end
