require 'csv'
require_relative 'contact'

class ContactRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @contacts = []
    @next_id = 1
    load_csv
  end

  def all
    @contacts
  end

  def create(contact)
    contact.id = @next_id
    @contacts << contact
    @next_id += 1
    save_csv
  end

  def update(id, attributes)
    contact = find(id)
    contact.name = attributes[:name] if attributes[:name]
    contact.email = attributes[:email] if attributes[:email]
    save_csv
  end

  def delete(id)
    @contacts.reject! { |contact| contact.id == id }
    save_csv
  end

  def find(id)
    @contacts.find { |contact| contact.id == id }
  end

  private

  def load_csv
    return unless File.exist?(@csv_file)

    CSV.foreach(@csv_file, headers: :first_row) do |row|
      contact = Contact.new(
        id: row["id"].to_i,
        name: row["name"],
        email: row["email"]
      )
      @contacts << contact
    end
    @next_id = @contacts.empty? ? 1 : @contacts.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["id", "name", "email"]
      @contacts.each do |contact|
        csv << [contact.id, contact.name, contact.email]
      end
    end
  end
end
