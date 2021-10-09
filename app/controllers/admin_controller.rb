class AdminController < ApplicationController
  before_action :admin_authorize!, :get_categories_layout

  layout "admin"

  private

  def get_categories_layout
    @translated_categories = []
    @key_names = []

    Category.find_each do |category|
      @translated_categories << category.category_translations.find_by(language_id: current_language.id)
      @key_names << category.key_name
    end
    p @translated_categories
  end

  def admin_authorize!
    authorize!
    redirect_to root_path, alert: "You don't have permission for this operation" unless current_user.admin?
  end
end
