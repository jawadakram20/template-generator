require 'rails_helper'

RSpec.describe Clause, :type => :model do
  describe "Associations" do
    it { should belong_to(:section).without_validating_presence }
  end

  it "is not valid without attributes" do
    clause = FactoryBot.create(:clause)
    clause.text=nil
    expect(clause).to_not be_valid
  end

  it "is valid with valid attributes" do
    clause = FactoryBot.create(:clause)
    expect(clause).to be_valid
  end
end