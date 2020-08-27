class MailingAddress < ApplicationRecord
	belongs_to :customer

	validates :postcode, presence: true, length: { maximum: 7, minimun: 7 },numericality: true
	validates :address, presence: true
	validates :name, presence: true

end
