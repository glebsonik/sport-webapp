class ArticlesController < AdminController
  def new
    category = Category.find_by(key_name: params[:key_name])
    @translated_category = category.category_translations.find_by(language_id: current_language.id)

    @conferences = category.conferences

    @translated_conferences = category.conferences.map do |conference|
      conference.conference_translations.find_by(language_id: current_language.id)
    end
  end

  def create
  end
end
