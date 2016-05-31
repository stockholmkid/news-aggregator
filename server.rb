require 'sinatra'
require 'pry'
require 'csv'

get "/articles" do
  @articles = []
  CSV.foreach('articles.csv', headers: true, header_converters: :symbol) do |row|
    article = row.to_hash
    @articles << article
  end
  erb :articles
end

get "/articles/new" do
  erb :form
end

post "/articles/new" do
  article_title = params['article_title']
  url = params['url']
  description = params['description']

  CSV.open("articles.csv", "ab") do |csv|
    csv << [article_title, url, description]
  end


  redirect "/articles"
end
