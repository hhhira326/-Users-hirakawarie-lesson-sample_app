class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    #params[:id]は文字列型の "1" ですが、findメソッドでは自動的に整数型に変換されます
    
    
    #debugger
    #ブラウザから /users/1 にアクセスし、Railsサーバーを立ち上げたターミナルを見るとbyebugプロンプトが表示されている。このプロンプトではRailsコンソールのようにコマンドを呼び出すことができて、アプリケーションのdebuggerが呼び出された瞬間の状態を確認することができます。
    #トラブルが起こっていそうなコードの近くにdebuggerを差し込んでシステムの状態を調べてみる


  end
  def new
    @user = User.new
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      #ユーザー登録中にログインを済ませる
      flash[:success] = "Welcome to the Sample App"
      #flashという変数は、ハッシュのように扱い、:successというキーに成功時のメッセージを代入
      #リダイレクトした直後のページで表示できるようになる
      redirect_to user_url(@user)
      #redirect_to user_url(@user) と同じ
      
    else
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
