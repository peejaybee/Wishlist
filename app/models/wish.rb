class Wish < ActiveRecord::Base
	belongs_to :user
	has_many :purchases
	
	def formattedItemPrice
		return  "$" + "%.2f" % (itemPrice / 100)
	end
	
	def itemsRemaining
		numberLeft = numberWanted
		purchases.each do |thispurchase|
			numberLeft = numberLeft - thispurchase.numberBought
		end
		return numberLeft
	end
end
