require './app/services/sanitizers/boolean_sanitizer.rb'

RSpec.describe BooleanSanitizer, type: :service do
  describe '.sanitize' do
    context 'when given boolean truthy string value' do
      subject(:sanitize) {BooleanSanitizer.sanitize(truthy_string_value)}
      let(:truthy_string_value) { "1" }
      it 'returns true' do
        expect(sanitize).to eq(true)
      end
    end

    context 'when given boolean falsy string value' do
      subject(:sanitize) {BooleanSanitizer.sanitize(falsy_string_value)}
      let(:falsy_string_value) { "0" }
      it 'returns false' do
        expect(sanitize).to eq(false)
      end
    end
  end
end