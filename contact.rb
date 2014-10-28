class Contact # Class is Blue print 
  attr_accessor :id, :first_name, :last_name, :email, :note #We have to use attr_accessor for bringing contact information to another class. especially Relodex class.
#この attr_accessor を置く事によって、他のクラスから
#first_nameなどを編集可能になる。

  def initialize(first_name, last_name, email, note) # cinitialized. The information from content become instance variable.
    @first_name = first_name                         # contact = Contact.new(first_name, last_name, email, note)
    @last_name = last_name
    @email = email
    @note = note 
  end

end
