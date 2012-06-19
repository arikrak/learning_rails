require 'spec_helper'

describe Post do



   let(:user) {FactoryGirl.create(:user)}
  before do
    #bad
    @post = user.posts.build(content: "Yo what up?")
  end

  subject {@post}

  it {should respond_to :content}
  it {should respond_to :user_id}
  it {should respond_to :user}
  its(:user){should == user}  #look over

  it {should be_valid}
  describe "if no user_id" do
     before{@post.user_id = nil}
     it{should_not be_valid}
  end

   describe "with blank content" do
     before { @post.content = " " }
     it { should_not be_valid }
   end

   describe "with content that is too long" do
     before { @post.content = "a" * 2000 } #400+ words?
     it { should_not be_valid }
   end


  describe "accessible attributes" do
     it "shouldn't allow access to user_id " do
        expect do
           Post.new(user_id: user.id)
            end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
        end
     end
end
