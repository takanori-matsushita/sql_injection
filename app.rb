require 'sinatra'
require 'sinatra/reloader'
require 'pg'

enable :sessions

before '/*' do
  if request.path == "/login"
  else
    redirect '/login' if session[:id].nil?
  end
end

def client
  PG::connect(
  :host => "",
  :user => '',
  :password => '',
  :dbname => ""
  )
end

get '/' do
  id = session[:id]
  @user = client.exec_params("select * from users where id = $1",[id])
  @posts = client.exec_params("select * from posts")
  
  erb :posts
end

get '/login' do
  erb :login
end

post '/login' do
  userid = params['userid']
  password = params['password']
  user = client.exec_params("select * from users where userid = $1",[userid])

  if user[0]['userid'] && user[0]['password'] == password
    session[:id] = user[0]['id']
    redirect "/welcome"
  else
    redirect "/login"
  end

end

get '/logout' do
  session.clear
  redirect '/login'
end

get '/welcome' do
  id = session[:id]
  @user = client.exec_params("select * from users where id = $1",[id])
  
  erb :welcome
end

post '/create' do
  title = params[:title]
  content = params[:content]
  date = Date.today
  client.exec_params("insert into posts(title, content, date) values($1, $2, $3)",[title, content, date])
  redirect "/"
end

get "/search" do
  id = session[:id]
  @user = client.exec_params("select * from users where id = $1",[id])
  @searchs = client.exec_params("select title, content, date from posts where title like '%#{params[:search]}%' or content like '%#{params[:search]}%'")
  @posts = client.exec_params("select * from posts")
  erb :search
end