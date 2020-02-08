require_relative('../models/budget')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')

require('pry')

budget1 = Budget.new(
  "amount" => "500"
)

merchant1 = Merchant.new(
  "name" => "Tesco"
)

merchant2 = Merchant.new(
  "name" => "Lothian Buses"
)

merchant3 = Merchant.new(
  "name" => "Odeon"
)

merchant4 = Merchant.new(
  "name" => "easyJet"
)

tag1 = Tag.new(
  "name" => "groceries"
)

tag2 = Tag.new(
  "name" => "business"
)

tag3 = Tag.new(
  "name" => "entertainment"
)

tag4 = Tag.new(
  "name" => "cinema"
)

tag5 = Tag.new(
  "name" => "travel"
)

tag6 = Tag.new(
  "name" => "personal"
)
