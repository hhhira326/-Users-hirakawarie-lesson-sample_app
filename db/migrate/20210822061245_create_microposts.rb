class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :microposts, [:user_id, :created_at]
    #user_idに関連づけられた全てのマイクロポストを作成時刻の逆順で取り出しやすくする
    #また、user_idとcreated_atの両方を１つの配列に含めることでActiveRecordは、両方のキーを同時に扱う複合キーインデックス(Multiple Key Index)を作成する
  end
end
