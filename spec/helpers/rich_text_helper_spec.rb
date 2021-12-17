require 'rails_helper'

RSpec.describe RichTextHelper, type: :helper do
  describe '.rich_text_as_string' do
    let(:string_with_br) {"First line<br>Second Line"}
    let(:string_with_raw_html) {"<h1>Test text in h1</h1> <a>Link</a> <b>Bold</b><hr>er<source/>"}
    let(:expected_string_with_new_line) {"First line\nSecond Line"}
    let(:expected_raw_string) {"Test text in h1 Link Bolder"}

    it 'transforms <br> tags to new line char' do
      expect(helper.rich_text_as_string(string_with_br)).to eq(expected_string_with_new_line)
    end

    it 'removes non-<br> html tags' do
      expect(helper.rich_text_as_string(string_with_raw_html)).to eq(expected_raw_string)
    end
  end
end
