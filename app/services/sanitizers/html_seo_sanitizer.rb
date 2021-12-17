class HtmlSeoSanitizer
  # Since trix editor support only h1 tag and does not support h2, h3 and so on
  # All content posted by trix should use h2 header instead of h1 to optimize SEO search
  def self.sanitize(content)
    content.gsub('<h1>', '<h2>').gsub('</h1>', '</h2>')
  end
end