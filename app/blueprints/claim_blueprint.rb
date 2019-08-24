class ClaimBlueprint < Blueprinter::Base
  identifier :id


  view :index do
    fields :user_state, :admin_state
    association :place, blueprint: PlaceBlueprint
  end

  view :create do
    field :place_price
  end

end

