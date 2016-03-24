ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/models/link.rb'
require './app/models/tag.rb'

require './app/models/data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb(:hello)

  end

  post '/links' do
    tag_array = params[:tag_name].split.map { |tag| Tag.first_or_create( :tag_name => tag ) }
    link = Link.create(link_address: params[:link_address], link_name: params[:link_name], tags: tag_array)
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/links')
  end

  get '/links/new' do
    erb(:'links/add_link')
  end

  get '/tags/:name' do
    tag = Tag.first(tag_name: params[:name])
    @links = tag ? tag.links : []
    erb(:'links/links')
  end

  #users

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect '/links'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
