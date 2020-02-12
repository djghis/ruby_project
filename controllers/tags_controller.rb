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
  redirect to '/transactions/new'
end

get '/tags/:id' do
  @tag = Tag.find(params['id'].to_i)
erb(:"tags/show")
end

get '/tags/:id/update' do
  @tag = Tag.find(params['id'].to_i)
  erb(:'tags/update')
end

post '/tags/:id/update' do
  Tag.new(params).edit
  redirect to '/tags'
end

post '/tags/:id/delete' do
  @tag = Tag.find(params[:id])
  @tag.delete()
  redirect to '/tags'
end
