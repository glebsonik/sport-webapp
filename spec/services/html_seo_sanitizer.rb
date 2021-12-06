require './app/services/sanitizers/html_seo_sanitizer.rb'

RSpec.describe HtmlSeoSanitizer, type: :service do
  describe '.sanitize' do
    subject(:sanitize) {described_class.sanitize(content)}
    let(:content) {"<h1>h1Lorem Ipsum</h1><div><br>Dolor sit amet<br><br><br></div><h1>Second h1?</h1>"}
    let(:expected_sanitized_content) {"<h2>h1Lorem Ipsum</h2><div><br>Dolor sit amet<br><br><br></div><h2>Second h1?</h2>"}

    it 'trnasforms <h1> </h1> to <h2> </h2>' do
      expect(sanitize).to eq(expected_sanitized_content)
    end
  end
end

