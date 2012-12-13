class MembershipsController < ApplicationController
	before_filter :authenticate_user!

  def batch_create_managers
		params[:emails].split(",").each do |email|
			@o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
			@pw = (0...8).map{ @o[rand(@o.length)] }.join

      if current_company.users.find_by_email(email).nil?
        @user = current_company.users.new(email: email, password: @pw, password_confirmation: @pw)
        @user.manager = 1
        @new_user = true
      else
        @user = current_company.users.find_by_email(email)
        @user.manager = 1
        @new_user = false
      end

      @user.save
      if @new_user
        UserMailer.invite_user(@user, current_user, current_site).deliver
      end
    end

    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Managers were successfully added.' }
    end
  end

  def batch_create_residents
    params[:emails].split(",").each do |email|
      @o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
      @pw = (0...8).map{ @o[rand(@o.length)] }.join

      @role = current_site.roles.find(params[:role])

      if User.find_by_email(email).nil?
        @user = current_company.users.new(email: email, password: @pw, password_confirmation: @pw)
        @user.manager = 0
        @new_user = true
      else
        @user = User.find_by_email(email)
        @new_user = false
      end

      if @user.company == current_company
        @membership = Membership.find_by_user_id_and_site_id(@user.id, current_site.id)
        if @membership.present?
          if @role.permission > @user.site_role(current_site).permission
            if (@role.permission == 4 && @user.manager?) || @role.permission < 4
              @membership.role = @role
              @membership.save
            end
          end
        else
          if @role.permission == 4 && @user.manager?
            @membership = current_site.memberships.new
            @membership.role = @role
            @membership.user = @user
            @membership.save
          elsif @role.permission < 4
            @membership = current_site.memberships.new
            @membership.role = @role
            @membership.user = @user
            if @new_user
              UserMailer.invite_user(@user, current_user, current_site).deliver
            end
            @membership.save
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to edit_site_url, notice: 'Residents were successfully added.' }
    end
  end
end