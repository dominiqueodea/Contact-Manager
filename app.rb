require_relative 'contact_repository'

repo = ContactRepository.new('contacts.csv')

loop do
  puts "\n--- Contact Manager ---"
  puts "1. List contacts"
  puts "2. Add contact"
  puts "3. Update contact"
  puts "4. Delete contact"
  puts "5. Exit"
  print "> "
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "\nContacts:"
    repo.all.each do |c|
      puts "#{c.id}. #{c.name} - #{c.email}"
    end

  when 2
    print "Name: "
    name = gets.chomp
    print "Email: "
    email = gets.chomp
    repo.create(Contact.new(name: name, email: email))
    puts "Contact added."

  when 3
    print "Enter ID to update: "
    id = gets.chomp.to_i
    contact = repo.find(id)
    if contact
      print "New name (#{contact.name}): "
      name = gets.chomp
      print "New email (#{contact.email}): "
      email = gets.chomp
      repo.update(id, name: name.empty? ? contact.name : name, email: email.empty? ? contact.email : email)
      puts "Contact updated."
    else
      puts "Contact not found."
    end

  when 4
    print "Enter ID to delete: "
    id = gets.chomp.to_i
    repo.delete(id)
    puts "Contact deleted."

  when 5
    puts "Goodbye!"
    break

  else
    puts "Invalid option."
  end
end
p[-\]
