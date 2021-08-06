「!!」(「バンバン (bang bang)」と読みます) という演算子を使うと、
そのオブジェクトを2回否定することになるので、
どんなオブジェクトも強制的に論理値に変換できます。

>> !!nil
=> fals

属性を更新する方法
update_attributesメソッドは属性のハッシュを受け取り、成功時には更新と保存を続けて同時に行います (保存に成功した場合はtrueを返します)。ただし、検証に1つでも失敗すると、 update_attributesの呼び出しは失敗します。特定の属性のみを更新したい場合は、次のようにupdate_attributeを使います。このupdate_attributeには、検証を回避するといった効果もあります。

>> user.update_attribute(:name, "El Duderino")
=> true