class ManagersController < ApplicationController
	layout "application"
	def index
		@sites = Site.all
	end
end