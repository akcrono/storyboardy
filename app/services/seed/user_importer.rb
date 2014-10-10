require_relative 'importer'

class UserImporter < Importer
  def create(attributes)

    if User.find_by(id: attributes[:id]).nil?
      user = FactoryGirl.build(:user)
      user.username = attributes[:username]
      user.role = attributes[:role]
      user.id = attributes[:id]
      user.save
    end
  end

  private

  def default_options
    { header_converters: :symbol, headers: true, col_sep: ',' }
  end
end
