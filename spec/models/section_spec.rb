require 'rails_helper'

RSpec.describe Section, :type => :model do

  describe "Associations" do
    it { should have_many(:clauses) }
  end

end