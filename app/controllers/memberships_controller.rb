class MembershipsController < ApplicationController
	before_filter :authenticate_user!

  def batch_create_managers
	  params[:emails].split(',').each do |email|
	    @o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
	    @pw = (0...8).map{ @o[rand(@o.length)] }.join
	    @user = User.find_by_email(email)
	
	    if @user.present?
	      @user.manager = true if @user.company == current_company  
        @user.save
	    else    
	      @user = current_company.users.new
	      @user.manager                 = true
	      @user.email                   = email
	      @user.password                = @pw
	      @user.password_confirmation   = @pw
	      if @user.save
	        UserMailer.invite_manager(@user, current_user).deliver
	      end
	    end
	  end
	
	  respond_to do |format|
	    format.html { redirect_to managers_url, notice: 'Managers added.' }
	  end
	end

  def batch_create_residents
	  @role = current_site.roles.find(params[:role])
	
	  params[:emails].split(',').each do |email|
	    @o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
	    @pw = (0...8).map{ @o[rand(@o.length)] }.join
	    
	    @user = User.find_by_email(email)
	    @site_role = @user.site_role(current_site) if @user.present?

	    if @user 
		    if ( @user.company != current_company ) || @user.manages?(current_site) 
		    	# already a manager or member of other company.  do nothing
		    	false
		    elsif @user.member?(current_site)
		    	# change their role
		    	@membership = Membership.find_by_user_id_and_site_id(@user.id, current_site.id)
		    	@membership.role = @role
		    	@membership.save
		    end
	    else
	    	# create the user
	    	@user = current_company.users.new
	      @user.email                   = email
	      @user.password                = @pw 
	      @user.password_confirmation   = @pw
	      @user.manager                 = true if @role.name == "Manager"
	
	      @membership = current_site.memberships.new
	      @membership.user = @user
	      @membership.role = @role  
	
	      if @user.save       
	        UserMailer.invite_user(@user, current_user, current_site).deliver
	      end
	    end
	  end

	  # finished looping through users
	  respond_to do |format|
	    format.html { redirect_to edit_site_url, notice: 'Success!' }
	  end
	end

end
