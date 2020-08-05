
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles'
  end

  get '/articles' do 
    @articles = Article.all
    erb :index
  end 

  post '/articles' do 
    params.delete(:submit)
    @new_article = Article.new(params)
    @new_article.save

    redirect "/articles/#{@new_article.id}"
  end 

  get '/articles/new' do 
    erb :new
  end 

  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end 

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end 

  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.update(title: params["title"], content: params["content"])

    redirect "/articles/#{@article.id}"
  end 

  delete '/articles/:id' do 
    Article.delete(params[:id])
    redirect "/articles"
  end
end
