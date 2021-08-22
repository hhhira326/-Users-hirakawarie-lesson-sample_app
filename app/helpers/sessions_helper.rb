module SessionsHelper

#渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    #ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成される。
  end

  #ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  #現在ログイン中のユーザーを返す(いる場合)
  #記憶トークンcookieに対応するユーザーを返す
  def current_user
    if  (user_id = session[:user_id])
      @current_user ||= User.find_by(id:user_id)
      #@current_user = @current_user ||  User.find_by(id:session[:user_id])の省略（or equals）      
    elsif (user_id = cookies.signed[:user_id]) 
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  #ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  #永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #記録したURL(もしくはデフォルト値)にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
    #deleteしておかないと次回も保護されたページに転送されてしまいブラウザを閉じるまで繰り返されてしまう
  end

  #アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
    #request.original_urlでリクエスト先が取得できます
    #getリクエストが送られたときだけurlを格納するようにifの条件文を使う。
  end
end
