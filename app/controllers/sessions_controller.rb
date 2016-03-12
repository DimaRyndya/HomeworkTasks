class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Добро пожаловать!'
    else
      flash.now.alert = 'Email или пароль не верный'
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Вы вышли'
  end
end
