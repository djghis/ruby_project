require_relative('../models/budget')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/transaction_tag')

require('pry')

TransactionTag.delete_all()
Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()
Budget.delete_all()


budget1 = Budget.new(
  "amount" => "500.00"
)

budget1.save()

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

transaction3 = Transaction.new(
  "amount" => "57.50",
  "merchant_id" => merchant1.id,
  "time_inserted" => "2020-01-11 14:11:10"
)

transaction4 = Transaction.new(
  "amount" => "520.50",
  "merchant_id" => merchant4.id,
  "time_inserted" => "2019-11-27 15:35:10"
)

transaction5 = Transaction.new(
  "amount" => "250.50",
  "merchant_id" => merchant4.id,
  "time_inserted" => "2019-10-23 12:10:10"
)

transaction6 = Transaction.new(
  "amount" => "200.00",
  "merchant_id" => merchant1.id,
  "time_inserted" => "2019-10-11 14:11:10"
)

transaction7 = Transaction.new(
  "amount" => "5.50",
  "merchant_id" => merchant3.id,
  "time_inserted" => "2020-01-02 10:10:10"
)

transaction8 = Transaction.new(
  "amount" => "1.00",
  "merchant_id" => merchant2.id,
  "time_inserted" => "2019-12-10 23:09:03"
)

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()
transaction6.save()
transaction7.save()
transaction8.save()


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

transaction_tag4 = TransactionTag.new(
  "transaction_id" => transaction3.id,
  "tag_id" => tag3.id
)

transaction_tag5 = TransactionTag.new(
  "transaction_id" => transaction3.id,
  "tag_id" => tag4.id
)

transaction_tag6 = TransactionTag.new(
  "transaction_id" => transaction3.id,
  "tag_id" => tag6.id
)

transaction_tag7 = TransactionTag.new(
  "transaction_id" => transaction5.id,
  "tag_id" => tag1.id
)

transaction_tag8 = TransactionTag.new(
  "transaction_id" => transaction6.id,
  "tag_id" => tag6.id
)

transaction_tag9 = TransactionTag.new(
  "transaction_id" => transaction6.id,
  "tag_id" => tag1.id
)

transaction_tag10 = TransactionTag.new(
  "transaction_id" => transaction7.id,
  "tag_id" => tag3.id
)

transaction_tag11 = TransactionTag.new(
  "transaction_id" => transaction7.id,
  "tag_id" => tag6.id
)

transaction_tag12 = TransactionTag.new(
  "transaction_id" => transaction7.id,
  "tag_id" => tag4.id
)

transaction_tag13 = TransactionTag.new(
  "transaction_id" => transaction8.id,
  "tag_id" => tag3.id
)

transaction_tag1.save()
transaction_tag2.save()
transaction_tag3.save()
transaction_tag4.save()
transaction_tag5.save()
transaction_tag6.save()
transaction_tag7.save()
transaction_tag8.save()
transaction_tag9.save()
transaction_tag10.save()
transaction_tag11.save()
transaction_tag12.save()
transaction_tag13.save()


binding.pry
nil
