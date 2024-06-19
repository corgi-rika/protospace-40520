class Prototype < ApplicationRecord
belongs_to :user
has_one_attached :image
# commentに対するアソシエーションを設定した（dependent: :destroyオプションを使用した）
has_many :comments, dependent: :destroy

validates :image, presence: true
validates :title, presence: true
validates :catch_copy, presence: true
validates :concept, presence: true

end
