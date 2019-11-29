class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to user
      flash[:notice] = 'ログインしました！'
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        remember user
        log_in(user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_url
        flash[:notice] = 'ログインしました!'
      else
        flash.now[:danger] = 'メールアドレスまたはパスワードが異なります!'
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
