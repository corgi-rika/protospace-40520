class CreatePrototypes < ActiveRecord::Migration[7.0]
  def change
    create_table :prototypes do |t|
      # 以下自分で追加しました
      t.string      :title,      null: false
      t.text        :catch_copy, null: false
      t.text        :concept,    null: false
      t.references  :user,       null: false, foreign_key: true
      # ここまで自分で追加
      t.timestamps
    end
  end
end
