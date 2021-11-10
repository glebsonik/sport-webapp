special_categories = ["Lifestyle", "Dealbook"]
en_lang = Language.find_or_create_by!(key: 'en')
special_categories.each do |category_name|
  category_key = LanguageKeyBuilder.key_for(category_name)
  category = Category.find_or_create_by!(key: category_key)
  category.category_translations.find_or_create_by!(language_id: en_lang.id, name: category_name)
end