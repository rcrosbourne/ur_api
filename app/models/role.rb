class Role < ActiveRecord::Base
	has_and_belongs_to_many :users
	validates :policies, presence: true
end
