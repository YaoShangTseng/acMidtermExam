class Message < ActiveRecord::Base
  validates_presence_of :title, :category_id

  has_many :comments
  belongs_to :user
end
