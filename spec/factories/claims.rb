FactoryBot.define do
  factory :claim do
  	talk_to_name {Faker::Name.name}
  	talk_to_position {Faker::Company.profession}
  	talk_to_contact {"+380682035831"}
  	claim_price {70}
  	comment {Faker::Lorem.sentence}

    place
    updates {["Text"]}
  end
end
