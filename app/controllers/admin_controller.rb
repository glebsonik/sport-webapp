class AdminController < ApplicationController
  before_action :admin_authorize!, :categories

  layout "admin"

  private

  def categories
    @translated_categories = CategoryTranslation.where(language_id: current_language.id).includes(:category)
  end

  def admin_authorize!
    if authorize! && current_user&.admin?
      redirect_to root_path, alert: "You don't have permission for this operation"
    end
  end
end
