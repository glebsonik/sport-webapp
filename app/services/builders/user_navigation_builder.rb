class UserNavigationBuilder
  CATEGORY_KEY    = 'category_key'
  CATEGORY_NAME   = 'category_name'
  CONFERENCE_KEY  = 'conference_key'
  CONFERENCE_NAME = 'conference_name'
  TEAM_ID         = 'team_id'
  TEAM_NAME       = 'team_name'

  def initialize(language)
    @language = language
  end

  def build
    { categories: build_categories }
  end

  private

  attr_reader :language

  def build_categories
    entities
      .group_by { |entity| [entity[CATEGORY_KEY], entity[CATEGORY_NAME]] }
      .map { |category_props, conferences| build_category(*category_props, conferences) }
  end

  def entities
    @entities ||= ActiveRecord::Base.connection.execute(query)
  end

  def build_category(key, name, conferences)
    {
      key: key,
      name: name,
      conferences: build_conferences(conferences)
    }
  end

  def build_conferences(conferences)
    conferences
      .group_by { |entity| [entity[CONFERENCE_KEY], entity[CONFERENCE_NAME]] }
      .map { |conference_props, teams| build_conference(*conference_props, teams) }
  end

  def build_conference(key, name, teams)
    {
      key: key,
      name: name,
      teams: teams.map(&method(:build_team))
    }
  end

  def build_team(entity)
    {
      id: entity[TEAM_ID],
      name: entity[TEAM_NAME]
    }
  end

  def query
    "SELECT
			category_translations.key AS #{CATEGORY_KEY},
			category_translations.name AS #{CATEGORY_NAME},
			conference_translations.key AS #{CONFERENCE_KEY},
			conference_translations.name AS #{CONFERENCE_NAME},
			teams.name AS #{TEAM_NAME},
			teams.id AS #{TEAM_ID}
		FROM
			category_translations
		LEFT JOIN conference_translations
			LEFT JOIN conferences ON conference_translations.conference_id = conferences.id
		ON category_translations.category_id = conferences.category_id
		LEFT JOIN teams ON conference_translations.conference_id = teams.conference_id
		WHERE
			conference_translations.language_id = #{ActiveRecord::Base.connection.quote(language.id)}
			AND category_translations.language_id = #{ActiveRecord::Base.connection.quote(language.id)}
			AND category_translations.key IS NOT NULL
      AND teams.id IS NOT NULL"
  end
end