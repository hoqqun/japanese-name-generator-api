# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'yaml'
require 'romaji'

NAMES = YAML.load_file('./db/names.yml')

NAMES["first_name"]["male"].each do |name|
  Name.new(roman_letter: Romaji.kana2romaji(name[1]), japanese: name[0], sex: :male).save
end

NAMES["first_name"]["female"].each do |name|
  Name.new(roman_letter: Romaji.kana2romaji(name[1]), japanese: name[0], sex: :female).save
end
