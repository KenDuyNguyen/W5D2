# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :string           not null
#  mod_id      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord 
  validates :title, :description, :mod_id, presence: true
  
  belongs_to :moderator, 
    foreign_key: :mod_id,
    class_name: :User
  
  has_many :post_subs
  
  has_many :posts,
    through: :post_subs,
    source: :post
end 
