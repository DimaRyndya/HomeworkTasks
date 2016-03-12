class Vote < ActiveRecord::Base
  belongs_to :petition
  validates :user_id, uniqueness: {scope: :petition_id}
end
