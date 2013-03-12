require 'spec_helper'

describe Task do
  it "creates valid user" do
    FactoryGirl.create(:task)
    Task.first.should be_valid
  end
  
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:consumer_id)}
  it { should belong_to :consumer}
  it { should belong_to :doer}
  
  it "'s consumers and doers are a kind of user" do
    users = FactoryGirl.create_list(:user, 2)
    task = FactoryGirl.create(:task, consumer_id: users[0].id, doer_id: users[1].id)
    task.consumer.should be_a(User)
    task.doer.should be_a(User)
  end
  context "state machine" do
    let(:task){ FactoryGirl.create(:task) }
    
    it "starts state machine with ready state" do
      task.state.should eq('ready')
    end
    
    it "does transition from ready to in_process" do
      task.apply!
      task.state.should eq('in_process')
    end
    
    it "does transitions from in_process to ready" do
      task.apply!
      task.cancel!
      task.state.should eq('ready')
    end
    
    it "does transitions from in_process to done" do
      task.apply!
      task.finish!
      task.state.should eq('done')
    end
    
    it "doesnt wrong transitions" do
      expect{task.cancel!}.to raise_error(/Cannot transition state/)
      expect{task.finish!}.to raise_error(/Cannot transition state/)
      task.apply!
      expect{task.apply!}.to raise_error(/Cannot transition state/)
    end
  end
end