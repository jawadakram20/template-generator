require 'rails_helper'

RSpec.describe 'Template', type: :request do
  describe 'POST /api/v1/template' do
    context 'with valid parameters of clause' do
      let!(:clause) { FactoryBot.create(:clause) }

      before do
        post '/api/v1/template', params: { plaintext: "This document is made of plaintext.Is made of [CLAUSE-#{clause.id}]"}
      end

      it 'returns the plaintext' do
        expect(json['plaintext']).to eq("This document is made of plaintext.Is made of  #{clause.text} ")
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters of clause' do
      let!(:clause) { FactoryBot.create(:clause) }

      before do
        post '/api/v1/template', params: { plaintext: "This document is made of plaintext.Is made of [CLAUSE-6]"}
      end

      it 'returns the plaintext' do
        expect(json['error']).to eq("Clause id not found")
      end

      it 'returns a 404' do
        expect(response).to have_http_status(:not_found)
      end
    end


    context 'with valid parameters of section' do
      let!(:plaintext ) { []}
      let!(:section) {  FactoryBot.create(:section) }
      

      before do
        plaintext << "This document is made of plaintext.Is made of "
        section.clauses.each do | sec|
          plaintext<< "#{sec.text};"
        end
        post '/api/v1/template', params: { plaintext: "This document is made of plaintext.Is made of [SECTION-#{section.id}]"}
      end

      it 'returns the plaintext' do
        
        expect(json['plaintext']).to eq("#{plaintext.join(" ")} ")
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters of section' do
      let!(:section) { FactoryBot.create(:section) }

      before do
        post '/api/v1/template', params: { plaintext: "This document is made of plaintext.Is made of [SECTION-6]"}
      end

      it 'returns the plaintext' do
        expect(json['error']).to eq("Section id not found")
      end

      it 'returns a 404' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with valid parameters of section and clause' do
      let!(:plaintext ) { []}
      let!(:section1) {  FactoryBot.create(:section) }
      let!(:clause1) { FactoryBot.create(:clause) }
      let!(:clause2) { FactoryBot.create(:clause) }
      
      before do
        section1.clauses.each do | sec|
          plaintext<< "#{sec.text};"
        end
        post '/api/v1/template', params: { plaintext: "This document is made of plaintext.
          Is made of [CLAUSE-#{clause1.id}].
          Is made of [CLAUSE-#{clause2.id}].
          Is made of [SECTION-#{section1.id}]"}
      end

      it 'returns the plaintext' do
        expect(json['plaintext']).to eq("This document is made of plaintext.
          Is made of  #{clause1.text} .
          Is made of  #{clause2.text} .
          Is made of  #{plaintext.join(' ')} ")
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters of section and clause' do
      let!(:clause) { FactoryBot.create(:clause) }

      before do
        post '/api/v1/template', params: { }
      end

      it 'returns the plaintext' do
        expect(json['error']).to eq("plaintext not found")
      end

      it 'returns a 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end