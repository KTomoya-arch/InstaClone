# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  images     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  #uploaderのsは必須
  mount_uploaders :images, ImageUploader
  #複数載せる時はserializsが必要らしい
  #ただ１つのカラムに対して複数のデータが入ってるのはよくあることなのか疑問
  serialize :images, JSON
  belongs_to :user
  validates :images, presence: true
  validates :body, presence: true, length: {maximum: 1000}
end
