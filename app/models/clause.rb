class Clause < ApplicationRecord
  belongs_to :section, optional: true
  validates :text, presence: true

end
