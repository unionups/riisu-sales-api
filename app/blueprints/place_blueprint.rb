class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :google_id, :address, :coordinate, :access_level, :price


end
