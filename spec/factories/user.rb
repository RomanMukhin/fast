FactoryGirl.define do
  sequence(:proper_email) {|u| "something#{u}@gmail.com"}

  factory :user do
	  name Faker::Name.name
    password Faker::Lorem.words(8)
    password_confirmation{|u| u.password}
    email  { generate(:proper_email) }
    admin false
    city Faker::Address.city
  end

  factory :admin, class: User do
    name Faker::Name.name
    password Faker::Lorem.words(8)
    password_confirmation{|u| u.password}
    email  { generate(:proper_email) }
    admin true
    city Faker::Address.city
  end
end

