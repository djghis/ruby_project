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
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb(:'transactions/new')
end

post '/transactions' do
 @transaction = Transaction.new(params)
 @transaction.save
  for tag in params['tag_id']
    TransactionTag.new("transaction_id" => @transaction.id, "tag_id" => tag).save
  end
 redirect to '/transactions'
end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'].to_i)
erb(:"transactions/show")
end

get '/transactions/:id/update' do
  @merchants = Merchant.all
  @tags = Tag.all
  @transaction = Transaction.find(params['id'].to_i)
  erb(:'transactions/update')
end

post '/transactions/:id/update' do
  Transaction.new(params).edit
   for tag in params['tag_id']
     TransactionTag.new("transaction_id" => params['id'], "tag_id" => tag).save
   end
  redirect to '/transactions'
end

post '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to '/transactions'
end
