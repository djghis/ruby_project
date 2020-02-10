require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/merchant')

also_reload('../models/*')

get '/merchants' do
  @merchants = Merchant.all()
  erb(:'merchants/index')
end

get '/merchants/new' do
  if params[:error] == "true"
    @error = "Merchant already exists!"
  end
  erb(:'merchants/new')
end

post '/merchants' do
  if Merchant.find_by_name(params['name']) == nil
    merchant = Merchant.new(params)
    merchant.save
  else redirect to '/merchants/new?error=true'
  end
  redirect to '/merchants'
end

get '/merchants/:id' do
  @merchant = Merchant.find(params['id'].to_i)
erb(:"merchants/show")
end

post '/merchants/:id/delete' do
  @merchant = Merchant.find(params[:id])
  @merchant.delete()
  redirect to '/merchants'
end
