FactoryBot.define do
  factory :user do
    phone_number {"+380682035831"}
    first_name {""}
    last_name {""}
    access_level {""} 
    referral_code {""}
    stat {{}}
    auth_token {""}
    factory :verified_user do
      add_attribute(:verification_code){"8334"}
    end
    factory :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end