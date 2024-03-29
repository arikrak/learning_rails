require 'spec_helper'

describe User do
  before { @user = User.new(name: "example name", email: "user@example.com", password: "foobar", password_confirmation: "foobar")}
  subject { @user}

it {should respond_to(:name)}
it {should respond_to(:email)}
it {should respond_to(:password_digest)}
it {should respond_to(:password_confirmation)}
it {should respond_to(:remember_token)}
it {should respond_to(:authenticate)}
it{should respond_to(:posts)}
it{should respond_to(:feed)}
it{should respond_to(:relationships)}

  it{ should be_valid}

  describe "if no name" do
    before {@user.name =" "}
    it {should_not be_valid}
  end

  describe "if no email" do
    before {@user.email =" "}
    it{ should_not be_valid}
  end

  describe "if long name" do
    before {@user.name = "z"*51}
    it {should_not be_valid}
  end

  describe "if valid email format" do
      it "should b valid" do
         addresses = %w[joe@shmo.com JOes_shMO12@opt.org ari.kra@sompl.co.il filt+jilt@blink.cn ]
         addresses.each do |addr|
          @user.email = addr
          @user.should be_valid
         end
      end
  end

  describe "if invalid email format" do
     it "should be invalid" do
        addresses = %w[joe.com joe#shmo.com joe@shmo,com joe@shmo@gmail.com joe@go+bla.com]
        addresses.each do |addr|
          @user.email = addr
          @user.should_not be_valid
        end
     end
  end

  describe "if email taken" do
     before do
       duplic = @user.dup
       duplic.email = @user.email.upcase
       duplic.save
     end
     it{ should_not be_valid}
  end

  describe "if no password" do
    before {@user.password = @user.password_confirmation = " "}
    it { should_not be_valid}
  end

  describe "if password aint match confirmation" do
      before {@user.password_confirmation = "notmatch"}
    it { should_not be_valid}
  end
  # can also add invalid test for nil password


  describe "return val of authenticate method" do
    before {@user.save}
    let(:found_user) {User.find_by_email(@user.email)}

    describe "if valid psswrd" do
      it {should == found_user.authenticate(@user.password)}
    end

    describe "if invalid psswrd" do
       let(:user_for_invalid_password) {found_user.authenticate("invalid")}

       it { should_not == user_for_invalid_password}
      specify {user_for_invalid_password.should be_false}
    end

  end

  #adding token
  describe "remember token" do
     before {@user.save}
    its(:remember_token) {should_not be_blank}
  end

  describe "post associations" do

    before { @user.save }
    let!(:older_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right posts in the right order" do
      @user.posts.should == [newer_post, older_post]
    end

    it "should destroy associated posts" do
      posts = @user.posts
      @user.destroy
      posts.each do |post|
        post.find_by_id(post.id).should be_nil
      end
    end
    
    
  end
  
  



end