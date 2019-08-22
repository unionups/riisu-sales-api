FactoryBot.define do
  factory :place do
    name { "Cafe Junior" }
    google_id { "as89dh8saydauni" }
    address { "21 Some St, Tokyo" }
    coordinate {{
      latitude: "122.22222",
      longitude: "30.11111"
    }}
    access_level { 0 }
    price { 80 }
  end
end

