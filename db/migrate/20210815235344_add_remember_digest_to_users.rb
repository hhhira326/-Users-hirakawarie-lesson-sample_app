class AddRememberDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_digest, :string
    #記憶ダイジェストはユーザーが直接読み出すことはないので (かつ、そうさせてはならないので)、remember_digestカラムにインデックスを追加する必要はありません。
  end
end
