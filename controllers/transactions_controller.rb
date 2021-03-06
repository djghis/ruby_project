require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/transaction_tag')
require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/budget')

also_reload('../models/*')

get '/transactions' do
  @transactions = Transaction.sort_by_time().reverse
  @merchants = Merchant.all
  @tags = Tag.all
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

post '/transactions/search' do
  if params['merchant_id']
    @search = Transaction.find_by_merchant(params['merchant_id'])
  elsif params['tag_id']
    @search = Transaction.find_by_tag(params['tag_id'])
  else
    @search = Transaction.find_all(params[:search])
      if @search.length == 0 || @search == nil
        @error = "No transactions found!"
      end
  end
  erb(:'transactions/search')
end

get '/transactions/summary' do
  erb(:'transactions/summary')
end

get '/transactions/current' do
  @transactions = Transaction.find_by_current_month
  erb(:'/transactions/current')
end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'].to_i)
  erb(:'transactions/show')
end

get '/transactions/:id/update' do
  @merchants = Merchant.all
  @tags = Tag.all
  @transaction = Transaction.find(params['id'].to_i)
  erb(:'transactions/update')
end

post '/transactions/:id/update' do
  TransactionTag.delete_by_transaction(params['id'])
  @transaction = Transaction.new(params)
  @transaction.edit
    params['tag_id'].each {|tag_id| TransactionTag.new("transaction_id" => params['id'], "tag_id" => tag_id).save}
  redirect to '/transactions'
end

post '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to '/transactions'
end
