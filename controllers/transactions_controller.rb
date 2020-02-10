require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/transaction_tag')
require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/budget')

also_reload('../models/*')

get '/transactions' do
  @transactions = Transaction.all()
  erb(:'transactions/index')
end

get '/transactions/new' do
  @merchants = Merchant.all()
  erb(:'transactions/new')
end

post '/transactions' do
 transaction = Transaction.new(params)
 transaction.save
 redirect to '/transactions'
end
