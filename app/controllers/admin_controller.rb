class AdminController < ApplicationController
  before_action :admin_authorize!, :categories

  layout "admin"

  private

  def categories
    #TODO: add cache delete when category update `Rails.cache.delete("recent_news")`

    @translated_categories ||= Rails.cache.fetch("admin_nav_categories") do
      CategoryTranslation.where(language_id: current_language.id).includes(:category)
    end
  end

  def admin_authorize!
    unless current_user&.present? && current_user&.active? && current_user&.admin?
      redirect_to root_path, alert: "You don't have permission for this operation"
    end
  end
end
