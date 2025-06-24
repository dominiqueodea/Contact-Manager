class Contact
  attr_accessor :id, :name, :email

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @email = attributes[:email]
  end
end
