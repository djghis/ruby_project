require_relative('../models/budget')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/transaction_tag')

require('pry')

# TransactionTag.delete_all()
# Transaction.delete_all()
# Tag.delete_all()
# Merchant.delete_all()
# Budget.delete_all()


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

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()


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

tag1.save()
tag2.save()
tag3.save()
tag4.save()
tag5.save()
tag6.save()


transaction1 = Transaction.new(
  "amount" => "5.00",
  "merchant_id" => merchant1.id
)

transaction2 = Transaction.new(
  "amount" => "150.00",
  "merchant_id" => merchant2.id
)

transaction1.save()
transaction2.save()


transaction_tag1 = TransactionTag.new(
  "transaction_id" => transaction1.id,
  "tag_id" => tag1.id
)

transaction_tag2 = TransactionTag.new(
  "transaction_id" => transaction1.id,
  "tag_id" => tag2.id
)

transaction_tag3 = TransactionTag.new(
  "transaction_id" => transaction2.id,
  "tag_id" => tag1.id
)

transaction_tag1.save()
transaction_tag2.save()
transaction_tag3.save()

binding.pry
nil
