class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  #何らかの処理が実行される直前に特定のメソッドを実行する仕組み。

  def index
    @users = User.paginate(page: params[:page])
    #ここで:pageパラメーターにはparams[:page]が使われていますが、これはwill_paginateによって自動的に生成されます。
  end

  def show
    @user = User.find(params[:id])
    #params[:id]は文字列型の "1" ですが、findメソッドでは自動的に整数型に変換されます
    @microposts = @user.microposts.paginate(page: params[:page])
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) #更新に成功した場合
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  #管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end  

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end

    #正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
