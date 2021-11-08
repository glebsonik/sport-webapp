class BooleanSanitizer
  def self.sanitize(boolean_string)
    boolean_string == "1" ? true : false
  end
end