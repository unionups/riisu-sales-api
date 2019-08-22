class UserBlueprint < Blueprinter::Base
  identifier :id

  view :full do
    fields :phone_number, :first_name, :last_name, :access_level, :referral_code, :stat
  end
  view :create do
    include_view :full
    field :auth_token, name: :token
  end

end
