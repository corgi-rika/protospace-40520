class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      #マイグレーションファイルに、テキストのためのカラムを追加した
      t.text        :text
      #マイグレーションファイルに、userおよびprototypeを参照するための外部キーを記述した（references型を用いる）
      t.references  :user, foreign_key: true
      t.references  :prototype, foreign_key: true
      t.timestamps
    end
  end
end
