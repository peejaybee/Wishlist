class UserController < ApplicationController
  layout "layouts/standard" , :except => [ :change_password, :edit, :signup]
  before_filter :login_required, :only => [:edit, :change_password, :add_wish, :add_purchase]
  before_filter :check_cookies

  def show
    # I want to be able to use show as an "index" page, so make provision for show with no ID.  This is probably dumb, and I should 
    # probably have a partial for showing and a partial for index, with different methods, but I want to get this done for now.
		if !@params["id"].nil?
			@user = User.find(@params["id"])
		elsif !@session['user'].nil?
			@user = @session['user']
		end
	end
	
	def list
		@user = User.find(@params["id"])
		render_partial "userMain", @user
	end
	
	def add_wish
		@user = get_user
		store_location
		redirect_to :controller => "wish", :action => "edit_new",:user_id => @user.id
	end
	
	def add_purchase
		@user = get_user
		@newpurchase = @user.purchases.create("purchaseDate"=> TimeZone.new("Central Time (US & Canada)").now, "wish_id" => @params["wishid"])
		redirect_to :controller => "purchase", :action => "edit", :id=>@newpurchase.id
	end

  def login
    case @request.method
      when :post
        if @session['user'] = User.authenticate(@params['user_login'], @params['user_password'])
          flash['notice']  = "Login successful"
          if @params['remember_me'] == "1"
            cookies['login'] = { :value => @params['user_login'], :expires => Time.now + 60 * 60 * 24 * 14}
            cookies['password'] = { :value => @params['user_password'], :expires => Time.now + 60 * 60 * 24 * 14}
          end
        else
          @login    = @params['user_login']
          @message  = "Login unsuccessful"
        end

      redirect_to :action => "show"
    end
  end
  
  def logout
    cookies.delete "login"
    cookies.delete "password"
    @session['user'] = nil
    redirect_to :action => "show"
  end
  
  def edit
    @user = get_user()
    case @request.method
    when :post
      if @user.update_attributes(@params['user'])      
        flash['notice']  = "Changes successful"
        redirect_back_or_default :action => "show", :id=>  @params["id"]        
      end
    end      
  end  
  
  def lookup
    case @request.method
    when :post
      @users = User.find_all([ "login LIKE ?", @params["loginid"] ])
    end
  end
  
  
  def search
    case @request.method
    when :post
      if @params["firstname"] == ""
        firstname = "%"
      else
        firstname = @params["firstname"]
      end
      if @params["lastname"] == ""
        lastname = "%"
      else
        lastname = @params["lastname"]
      end
      if @params["city"] == ""
        city = "%"
      else
        city = @params["city"]
      end
      if @params["state"] == ""
        state = "%"
      else
        state = @params["state"]
      end
        
      @users = User.find_all([ "firstName LIKE ? AND lastName LIKE ? AND city LIKE ? AND state LIKE ?", firstname,lastname,city,state ])
      render_partial_collection ("search_result", @users)
    end
  end

  def signup
    case @request.method
      when :post
        @user = User.new(@params['user'])
        
        if @user.save      
          @session['user'] = User.authenticate(@user.login, @params['user']['password'])
          flash['notice']  = "Signup successful"
           redirect_back_or_default :action => "show", :id=>@session['user'].id
       end
      when :get
        @user = User.new
    end      
  end  

	def change_password
	 	@user = get_user
		case @request.method
		when :post
			@user.change_password(@params['user']['password'])
			flash['notice']  = "Password Changed"
			redirect_back_or_default :action => "show"  , :id=>  @params["id"]   
		end      
	end  


protected
    def authenticate
      unless @session['user']
        @session["return_to"] = @request.request_uri
        redirect_to :action => "login"
        return false
      end
    end
    
    
    
  def get_user
    #basically, most operations should be done only on the logged-in user, but admins can work on any user
    @myuser = @session['user']
    if @myuser.admin  == 1
      @myuser = User.find(@params["id"])
    end
    return @myuser
  end
   
  def check_cookies
    unless @session['user']
      @session['user'] = User.authenticate(cookies['login'], cookies['password'])
    end
  end



end
