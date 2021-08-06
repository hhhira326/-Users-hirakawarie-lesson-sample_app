class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    #usersデーブルのemailカラムにindexを追加するためのRailsのadd_indexメソッド
    #オプションでunipue :trueにすることで一意性を強制
    #emailカラムにindexを追加することで全表スキャンをせず効率的にする
  end
end
