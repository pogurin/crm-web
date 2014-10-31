require "sinatra"
require "sinatra/reloader" if development?


require_relative 'rolodex'
require_relative 'contact'
#require 'sinatra'

$rolodex = Rolodex.new

get '/' do
	@crm_app_name = "My CRM" #route 
	erb :index
end

get "/contacts" do
	@contacts = $rolodex.contacts
	erb :contacts
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

get "/contacts/:id/edit" do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end


put "/contacts/:id" do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]

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


#DELETE
# <h1>Edit a Contact</h1>

# <form action="/contacts/<%= @contact.id %>" method="post">  
#   <input type="hidden" name="_method" value="put">
 



delete '/contacts/:id' do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		
		$rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

