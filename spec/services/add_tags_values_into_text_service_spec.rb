require 'rails_helper'

RSpec.describe AddTagsValuesIntoTextService, type: :model do
  describe '#get_document' do
    let!(:plaintext ) { []}
    let!(:section1) {  FactoryBot.create(:section) }
    let!(:clause1) { FactoryBot.create(:clause) }
    let!(:clause2) { FactoryBot.create(:clause) }

    it 'adding tags values into text' do
      section1.clauses.each do | sec|
        plaintext<< "#{sec.text};"
      end
      text=AddTagsValuesIntoTextService.new("This document is made of plaintext.
        Is made of [CLAUSE-#{clause1.id}].
        Is made of [CLAUSE-#{clause2.id}].
        Is made of [SECTION-#{section1.id}]").get_document

      expect(text).to eq("This document is made of plaintext.
        Is made of  #{clause1.text} .
        Is made of  #{clause2.text} .
        Is made of  #{plaintext.join(' ')} ")
    end
  end
end
