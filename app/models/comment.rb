class Comment < ApplicationRecord
  # Commentモデルに、userおよびprototypeに対するアソシエーションを設定した
  belongs_to :user
  belongs_to :prototype

  # Commentモデルに、テキストに関するバリデーションを記述した
  validates :text, presence: true
end
