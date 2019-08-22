class PlaceBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :google_id, :address, :coordinate, :access_level, :price
  field :claimed do |place, options|
    false
  end
end

