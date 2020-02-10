require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/transaction_tag')
require_relative('../models/tag')

also_reload('../models/*')

get '/tags' do
  @tags = Tag.all()
  erb(:'tags/index')
end

get '/tags/new' do
  @error = ""
  if params[:error] == "true"
    @error = "Tag already exists!"
  end
  erb(:'tags/new')
end

post '/tags' do
  if Tag.find_by_name(params['name']) == nil
    tag = Tag.new(params)
    tag.save
  else redirect to '/tags/new?error=true'
  end
  redirect to '/tags'
end

get '/tags/:id' do
  @tag = Tag.find(params['id'].to_i)
erb(:"tags/show")
end
