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
      after(:create) {|admin| admin.add_role(:admin)}
      phone_number {"+380682035832"}
    end
  end
end