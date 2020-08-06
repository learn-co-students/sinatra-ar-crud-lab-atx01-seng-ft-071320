
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.new
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @art = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @art = Article.find(params[:id])
    @art.update(title: params[:title])
    @art.update(content: params[:content])
    redirect "/articles/#{@art.id}"
  end

  delete '/articles/:id' do
    @art = Article.find(params[:id])
    @art.destroy
    redirect "/articles"
  end

end
