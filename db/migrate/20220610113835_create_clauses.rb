class CreateClauses < ActiveRecord::Migration[6.0]
  def change
    create_table :clauses do |t|
      t.string :text
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end
