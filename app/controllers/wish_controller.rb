class WishController < ApplicationController
#layout "layouts/standard" 
#before_filter :store_location
before_filter :login_required

	def edit_new
		@user = User.find(@params["user_id"])
		@wish = @user.wishes.new("wishDate"=> TimeZone.new("Central Time (US & Canada)").now)

		case @request.method
		when :post
			@params['wish']['itemPrice'] = @params['wish']['itemPrice'].gsub(/[^0-9.]/,"").to_i * 100
			if @wish.update_attributes(@params['wish'])      
				flash['notice']  = "Changes successful"
			end
			redirect_to :controller=> "user", :action => "show", :id=>userid
		end      
	end

	def edit
		@wish = Wish.find(@params["id"])
		userid = @wish.user.id

		case @request.method
		when :post
			@params['wish']['itemPrice'] = @params['wish']['itemPrice'].gsub(/[^0-9.]/,"").to_i * 100
			if @wish.update_attributes(@params['wish'])      
				flash['notice']  = "Changes successful"
			end
			redirect_to :controller=> "user", :action => "show", :id=>userid
		end      
	end
	
	def show
		@wish = Wish.find(@params["wish_id"])
		@userid = @wish.user.id
	end
	
	def remove
	#if there are no purchases delete it, otherwise hide the wish
		@wish = Wish.find(@params["id"])
		userid = @wish.user.id
		
		if @wish.purchases.size > 0
			@wish.update_attribute("visible",0)
		else
			@wish.destroy
		end
		render_text ""
#		redirect_to :controller=> "user", :action => "show", :id=>userid
	end

end
