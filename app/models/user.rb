class User < ApplicationRecord
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
  validates :password, presence: true, length: { minimum: 6 }

end
