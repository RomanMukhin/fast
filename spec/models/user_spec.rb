require 'spec_helper'

describe User do
  it "creates valid user" do
    FactoryGirl.create(:user)
    User.first.should be_valid
  end
  
  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("a@b.com").for(:email) }
  it { should ensure_length_of(:password).is_at_least(8)  }
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:email)} 
  it { should have_many :offers}
  it { should have_many :things}

  it "offers and things are a kind of task" do
    FactoryGirl.build(:user).offers.build.should be_a(Task)
    FactoryGirl.build(:user).things.build.should be_a(Task)
  end
end