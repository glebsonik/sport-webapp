class HtmlSeoSanitizer
  def self.sanitize(content)
    content.gsub('<h1>', '<h2>').gsub('</h1>', '</h2>')
  end
end