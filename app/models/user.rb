class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  #マイクロポストはその所有者(ユーザー)と一緒に破棄されることを保証する
  attr_accessor :remember_token
  before_save {self.email = email.downcase} 
  #dbに保存する前に小文字に変換する before_saveコールバックメソッド
  #{}内の右辺はself.が省略されている

  validates :name, presence: true, length: { maximum:50}
  #validates(:name,presence: true)カッコは省略
  #("name", {presence: true}. {length: { maximum:50}})
  #validates :カラム名, 制約: true
  #nameの値が存在するか(空文字でない)、長さは50以下

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #正規表現
  validates :email,presence: true, length: { maximum: 255 },
  format: {with: VALID_EMAIL_REGEX},#引数に正規表現(regex)を取る
  uniqueness: {case_sensitive: false} 
  #大文字小文字を無視した一意性を強制 validatesメソッドの:unipueオプション

  has_secure_password
  #セキュアにハッシュ化してパスワードを、db内のpassword_digestという属性に保存できるようになり、これがmodel内に含まれていることがメソッドを使える条件
  # 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される18 。
  # authenticateメソッドが使えるようになる (引数の文字列(パスワード)がハッシュ化した値と、DB内にあるpassword_digestカラムの値を比較する。パスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  #試作feedの定義
  #完全な実装は14章
  def feed
    Micropost.where("user_id = ?",id)
  end

  class << self
    #User.digest → self.digest → digestにできる。selfはUser「クラス」を指す

    #渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    #ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end


  #永続セッションのためにユーザーをDBに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil? #ダイジェストが存在しない場合に対応
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


  #ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
