module RichTextHelper
    def rich_text_as_string(rich_string)
      rich_string.gsub('<br>', "\n").gsub(/(<\/?.+?>)/, "")
    end
end
