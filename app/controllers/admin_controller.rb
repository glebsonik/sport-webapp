class AdminController < ApplicationController
  before_action :admin_authorize!, :get_categories_layout

  layout "admin"

  private

  def get_categories_layout
    @translated_categories = CategoryTranslation.where(language_id: current_language.id).includes(:category)
  end

  def admin_authorize!
    authorize!
    redirect_to root_path, alert: "You don't have permission for this operation" unless current_user.admin?
  end
end
