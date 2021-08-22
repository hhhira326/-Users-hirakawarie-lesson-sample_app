class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #入力されたメールアドレスを持つユーザーがデータベースに存在し、かつ入力されたパスワードがそのユーザーのパスワードである場合のみ、if文がtrueになる
      log_in user
      params[:session][:remember_me] == '1'? remember(user) :forget(user)
      #記憶トークンの生成、DBに保存.
      #チェックボックスがオンの時に'1'になりオフの時に'0'になる
      redirect_back_or user #フレンドリーフォワーディングを備える
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    #ログイン中の場合のみログアウトする
    redirect_to root_url
  end
end
