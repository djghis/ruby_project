require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/budgets_controller')
require_relative('controllers/merchants_controller')
require_relative('controllers/tags_controller')
require_relative('controllers/transactions_controller')

also_reload('models/*')

get '/welcome' do
  @wrapper_id = 'id="transparent"'
  @large_logo = true
  erb(:'welcome/welcome')
end

get '/' do
  @remaining_budget = Budget.remaining_monthly_budget()
  @budget_colour = Budget.check_current_budget()
  @wrapper_id = 'id="transparent"'
  erb(:home)
end
