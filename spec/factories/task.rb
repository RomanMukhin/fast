FactoryGirl.define do
  factory :task do |f|
  	f.title Faker::Lorem.words(1)
  	f.description Faker::Lorem.words(3)
    f.consumer_id Faker::Base.numerify("###")
    f.doer_id Faker::Base.numerify("###")
  end
end