module SessionsHelper

#渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    #ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成されます。
  end

  #現在ログイン中のユーザーを返す(いる場合)
  def current_user
    if  session[:user_id]
      @current_user ||= User.find_by(id:session[:user_id])
      #@current_user = @current_user ||  User.find_by(id:session[:user_id])の省略（or equals）      
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
end
