class UserCategoriesBreadcrumbsPresenter
  def initialize(navigation, params)
    @navigation = navigation
    @category_key = params[:category]
    @conference_key = params[:conference]
    @team_id = params[:team]
  end

  def breadcrumbs
    @breadcrumbs ||= {
      category: prepare_category.slice(:key, :name),
      conference: prepare_conference&.slice(:key, :name),
      team: prepare_team&.slice(:id, :name)
    }
  end

  private
  attr_reader :navigation

  def prepare_category
    navigation[:categories].find{|category| category[:key] == @category_key}
  end

  def prepare_conference
    prepare_category[:conferences].find{|conference| conference[:key] == @conference_key} if @conference_key.present?
  end

  def prepare_team
    prepare_conference[:teams].find{|team| team[:id] == @team_id.to_i} if @team_id.present?
  end
end