class SitesController < ApplicationController
  before_action :user_required

  def index
    @sites = Site.with_attached_image.includes(:user).order(created_at: :desc).page params[:page]
    @site  = Site.new
  end

  def create
    @site = @current_user.sites.build params.fetch(:site, {}).permit(:url)

    respond_to do |format|
      if @site.save
        format.html { redirect_to sites_url, notice: 'Site capture was successfully created.' }
      else
        format.html do
          @sites = Site.with_attached_image.includes(:user).order(created_at: :desc).page params[:page]
          render :index
        end
      end
      # TODO: should refactor `create.json.jbuilder` and handle error handling here instead. But leaving for now
      format.json
    end
  end

end
