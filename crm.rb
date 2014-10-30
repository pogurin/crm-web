require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new

get '/' do
	@crm_app_name = "My CRM" #route 
	erb :index
end

get "/contacts" do

	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

# post '/contacts' do
# 	puts params
# end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	puts params # putsを入れることで、サーバー上での動きが確認可能。
	redirect to('/contacts')
end	



