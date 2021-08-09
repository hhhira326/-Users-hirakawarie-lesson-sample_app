module UsersHelper
#デフォルトでは、ヘルパーファイルで定義されているメソッドは自動的にすべてのビューで利用できます。
#ここでは、利便性を考えてgravatar_forをUsersコントローラに関連付けられているヘルパーファイルに置く
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #GravatarのURLはユーザーのメールアドレスをMD5という仕組みでハッシュ化しています。Rubyでは、Digestライブラリのhexdigestメソッドを使うと、MD5のハッシュ化が実現できます。
    #MD5ハッシュでは大文字と小文字が区別されるので、Rubyのdowncaseメソッドを使ってhexdigestの引数を小文字に変換しています。
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end      
end
