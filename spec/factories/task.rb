FactoryGirl.define do
  factory :task do
    title       {   Faker::Lorem.characters(8)}
    description {   Faker::Lorem.characters(8)}
    consumer    {   FactoryGirl.create(:user)}
    doer        {   FactoryGirl.create(:user)}
  end

  factory :applied_task, parent: :task do
  	after(:create) do |task, evaluator|
      task.apply
    end
  end
  
  factory :offer, parent: :task do
    doer nil
  end

  factory :valid_task, class: Task do
    title       {   Faker::Lorem.characters(8)}
    description {   Faker::Lorem.characters(8)}
  end

  factory :invalid_task, class: Task do
    title           ""     
    description {   Faker::Lorem.characters(8)}
  end         
end
