class UserBlueprint < Blueprinter::Base
	identifier :id

	view :normal do
    field :phone_number
    field :auth_token, name: :token
  end

end
