require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/budget')

also_reload('../models/*')

get '/budget/update' do
  erb(:'budget/update')
end

post '/budget' do
 Budget.delete_all()
 budget = Budget.new(params)
 budget.save
 redirect to '/'
end
