# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Section.destroy_all
Clause.destroy_all
section = Section.create(id: 1)
Clause.create(id: 1, text: 'The quick brown fox',section_id: section.id)
Clause.create(id: 2, text: 'jumpsover the lazy dog',section_id: section.id)
Clause.create(id: 3, text: 'And dies')
Clause.create(id: 4, text: 'The white horse is white' )