FactoryGirl.define do
  factory :user do |f|
	  f.name Faker::Name.name
    f.password Faker::Lorem.words(8)
    f.password_confirmation{|u| u.password}
    f.sequence(:email) {|u| "something#{u}@gmail.com"}
    f.admin false
    f.city Faker::Address.city
  end

  factory :task do |f|
  	f.title Faker::Lorem.words(1)
  	f.description Faker::Lorem.words(3)
    f.consumer_id {rand(10)}
    f.doer_id {rand(10)}
  end
end