class UserApplicationController < ApplicationController
  before_action :navigation

  layout "user"

  private

  def navigation
    @navigation = UserNavigationBuilder.new(current_language).build
  end

end