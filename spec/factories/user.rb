FactoryGirl.define do
  sequence(:proper_email) {|u| "something#{u}@gmail.com"}

  factory :user do
	  name                 {    Faker::Name.name          }
    password             {    Faker::Lorem.characters(8)}
    password_confirmation{    |u|   u.password          }
    email                {    generate(:proper_email)   }
    admin                     false
    city                 {    Faker::Address.city       }
    avatar                    nil
  end

  factory :admin, parent: :user do
    admin true
  end
end

