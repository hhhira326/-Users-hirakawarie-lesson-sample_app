class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
    #add_columnメソッドを使ってusersテーブルpassword_digestカラムを追加
  end
end

#カラム追加の際、
# rails g migration add_password_digest_to_users password_digest:string
# 末尾をto_usersにしておくとusersテーブルにカラムを追加するマイグレーションが自動的に作成される

#has_secure_passwordを使ってパスワードをハッシュ化するためには、最先端のハッシュ関数であるbcryptが必要なのでbcrypt gemをGemfileに追加
