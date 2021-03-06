require_dependency "storytime/application_controller"

module Storytime
  module Dashboard
    class SitesController < DashboardController
      before_action :set_site, only: [:edit, :update]
      before_action :redirect_if_site_exists, only: :new
      
      def new
        @site = Site.new
        authorize @site
      end

      def edit
        authorize @site
      end

      def create
        @site = Site.new(site_params)
        authorize @site

        if @site.save_with_seeds(current_user)
          redirect_to edit_dashboard_site_url(@site), notice: I18n.t('flash.sites.create.success')
        else
          render :new
        end
      end

      def update
        authorize @site
        flash[:notice] = I18n.t('flash.sites.update.success') if @site.update(site_params)
        render :edit
      end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_site
        @site = Site.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def site_params
        params.require(:site).permit(:title, :post_slug_style, :ga_tracking_id, :root_page_content, :root_post_id)
      end

      def redirect_if_site_exists
        redirect_to edit_dashboard_site_url(Site.first) if Site.first
      end

    end
  end
end
