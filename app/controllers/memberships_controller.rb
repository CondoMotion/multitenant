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
	    format.html { redirect_to sites_url, notice: 'Managers added.' }
	  end
	end

  def batch_create_residents
	  @role = current_site.roles.find(params[:role])
	
	  params[:emails].split(',').each do |email|
	    @o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
	    @pw = (0...8).map{ @o[rand(@o.length)] }.join
	    @user = User.find_by_email(email)
	
	    if @user.present?       
	      if @user.company == current_company        
	        if Membership.find_by_user_id_and_site_id(@user.id, current_site.id).present? 
	          if @role.permission > @user.site_role(current_site).permission  
	            @membership = Membership.find_by_user_id_and_site_id(@user.id, current_site.id)  
	            if @role.name == "Manager"  
	              @membership.role = @role if @user.manager?
	            else  
	              @membership.role = @role
	            end 
	          end   
	        else      
	          if @role.name == "Manager"    
	            if @user.manager?
	              @membership = current_site.memberships.new
	              @membership.user = @user
	              @membership.role = @role  
	            end 
	          else
	            @membership = current_site.memberships.new
	            @membership.user = @user
              @membership.role = @user.manager? ? current_site.roles.find_by_name("Manager") : @role
	          end   
	        end
	        @membership.save     
	      end       
	    else
	      @user = current_company.users.new
	      @user.email                   = email
	      @user.password                = @pw 
	      @user.password_confirmation   = @pw
	      @user.manager                 = true if @role.name == "Manager"
	
	      @membership = current_site.memberships.new
	      @membership.user = @user
	      @membership.role = @role  
	
	      if @membership.save       
	        UserMailer.invite_user(@user, current_user, current_site).deliver
	      end
	    end     
	  end
	
	  respond_to do |format|
	    format.html { redirect_to edit_site_url, notice: 'Members added.' }
	  end
	end  

end
