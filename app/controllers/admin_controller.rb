class AdminController < ApplicationController
  before_action :admin_authorize!, :categories

  layout "admin"

  private

  def categories
    @translated_categories ||= Rails.cache.fetch(CategoryTranslation::CACHE_KEY) do
      CategoryTranslation.where(language_id: current_language.id)
    end
  end

  def admin_authorize!
    unless current_user&.present? && current_user&.active? && current_user&.admin?
      redirect_to root_path, alert: "You don't have permission for this operation"
    end
  end
end
