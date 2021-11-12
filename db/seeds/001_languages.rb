Language.find_or_create_by!(key: 'en', display_name: 'English', hidden: false)

Language.find_or_create_by!(key: 'ua', display_name: 'Ukrainian', hidden: false)
Language.find_or_create_by!(key: 'fr', display_name: 'Francas', hidden: true)
Language.find_or_create_by!(key: 'de', display_name: 'Deutsch', hidden: true)