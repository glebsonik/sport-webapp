class CategorySeeder
  def initialize(language)
    @language = language
  end

  def seed_data(hierarchy)
    hierarchy.each do |category_hash|
      conferences = category_hash.delete(:conferences)
      category_key, category_translation = category_hash.to_a[0]
      category = Category.find_or_create_by!(key_name: category_key)
      category.category_translations.find_or_create_by!(language_id: @language.id, name: category_translation)
      seed_conferences(category, conferences)
    end
  end

  private

  def seed_conferences(category, conferences)
    conferences.each do |conference_hash|
      teams = conference_hash.delete(:teams)
      conference_key, conference_translation = conference_hash.to_a[0]
      conference = category.conferences.find_or_create_by!(key_name: conference_key)
      conference.conference_translations.find_or_create_by!(language_id: @language.id, name: conference_translation)
      seed_teams(conference, teams)
    end
  end

  def seed_teams(conference, teams)
    teams.each do |team_hash|
      team_key, team_name = team_hash.to_a[0]
      conference.teams.find_or_create_by!(name: team_name)
    end
  end
end