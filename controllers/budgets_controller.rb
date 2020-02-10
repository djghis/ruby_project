require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/budget')

also_reload('../models/*')

get '/budget/update' do
  if params[:error] == "true"
    @error = "Sorry, your budget has to be more than 0!"
  end
  erb(:'budget/update')
end

post '/budget' do
 Budget.delete_all()
 budget = Budget.new(params)
  if budget.amount.to_i < 0
    redirect to '/budget/update?error=true'
  else
    budget.save
    redirect to '/'
  end
end
