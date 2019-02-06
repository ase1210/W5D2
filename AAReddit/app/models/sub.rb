# == Schema Information
#
# Table name: subs
#
#  id           :bigint(8)        not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    primary_key: :id, 
    foreign_key: :moderator_id,
    class_name: :User 

    has_many :postsubs

    has_many :posts,
      through: :postsubs,
      source: :post
end
