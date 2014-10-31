class Rolodex
  attr_reader :contacts

  # def contacts 
  #   return @contacts 
  # end

  def initialize
    @contacts = []
    @id = 1000
  end

  def remove_contact(contact)
    @contacts.delete(contact)
  end

  def find(contact_id)
    @contacts.find{|contact|contact.id == contact_id}
  end

  def add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end
end