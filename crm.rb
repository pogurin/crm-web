# require "sinatra"
# require "sinatra/reloader" if development?



require_relative 'rolodex'

require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3") 

class Contact
	include DataMapper::Resource
	
	property :id, Serial
 	property :first_name, String
 	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!


post "/contacts" do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
		)
		redirect to('/contacts')
end

get "/contacts" do 
	@contacts = Contact.all #Mapper
	erb :contacts
end

# get "/contacts" do
# 	@contacts = $rolodex.contacts
# 	erb :contacts
# end


$rolodex = Rolodex.new

get '/' do
	@crm_app_name = "My CRM" #route 
	erb :index
end


get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	puts params # putsを入れることで、サーバー上での動きが確認可能。
	redirect to('/contacts') 
end	

#Show
get'/contacts/:id/show' do # ここの順番。
	@contact = $rolodex.find params[:id].to_i
	erb :show_contact
end 

get "/contacts/1000" do
	@contact = $rolodex.find(1000)
	erb :show_contact
end

#EDIT

get "/contacts/:id/edit" do #
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact 
	else
		raise Sinatra::NotFound
	end
end


put "/contacts/:id" do #パラムズは、ハッシュとのこと。
	@contact = Contact.get(params[:id].to_i)
	# @contact.update(:first=name => params[:first_name], :last_name => params[:last_name], )

	if @contact 
		@contact.update(:first_name => params[:first_name])
		@contact.update(:last_name => params[:last_name])
		@contact.update(:email => params[:email])
		@contact.update(:note => params[:note])

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

# Method POST
# post '/contacts' do
# 	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
# 	$rolodex.add_contact(new_contact)
# 	puts params # putsを入れることで、サーバー上での動きが確認可能。
# 	redirect to('/contacts') 
# end	


# Delete #迷ったのは、get の部分とgetに対応するファイルがなかったから。hiddenのコマンドを作成しないとだめ　。


delete '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	if @contact.destroy
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end



