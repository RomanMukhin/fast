FactoryGirl.define do
  factory :task do
  	title {Faker::Lorem.word}
  	description {Faker::Lorem.word}
    consumer_id {Faker::Base.numerify("###")}
    doer_id {Faker::Base.numerify("###")}
  end
end