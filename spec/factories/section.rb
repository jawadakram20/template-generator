FactoryBot.define do 
  factory :section do 
    clauses { [ FactoryBot.create(:clause) , FactoryBot.create(:clause)] }
  end
end