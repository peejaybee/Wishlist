class PurchaseController < ApplicationController
#layout "layouts/standard" 

before_filter :store_location, :only =>  [:edit, :remove]
before_filter :login_required, :only =>  [:edit, :remove]
before_filter :check_ownership, :only => [:edit, :remove]



  def edit
    @purchase = Purchase.find(@params['id'])
    @userid = @purchase.user.id
    case @request.method
    when :post
      if @purchase.update_attributes(@params['purchase'])      
        flash['notice']  = "Changes successful"
        redirect_back_or_default :controller=> 'user', :action => 'show', :id=> @userid
      end
    end      
  end

 
  def remove
    @purchase = Purchase.find(@params['id'])
    @userid = @purchase.user.id
	if @purchase.confirmed == 1
		@purchase.update_attribute("visible",0)
	else
		@purchase.destroy
	end
	render_text ""
#    redirect_back_or_default :controller=> 'user', :action => 'show', :id=> @userid
  end

  def check_ownership
    @user = @session['user']
    @purchase = Purchase.find(@params['id'])
    if @user.admin != 1 and @user != @purchase.user
	redirect_to :controller=> 'user', :action => 'show', :id=> @user.id
    end
  end

end
