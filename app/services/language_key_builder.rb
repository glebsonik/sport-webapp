class LanguageKeyBuilder
  def self.key_for(string)
    string.gsub(/\s+/,'_').downcase
  end
end