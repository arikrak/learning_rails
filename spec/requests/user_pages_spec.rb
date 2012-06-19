require 'spec_helper'

describe "UserPages" do

  subject{page}

  describe "signup page" do
    before{ visit signup_path}
    it{ should have_selector('title', text: "Sign Up")  }
    it{ should have_selector('h1', text: "Sign Up" )  }

    let(:submit) {"Create account"}

    describe "if invalid info" do
      it "shouldnt create user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "if valid info" do
      before do
        fill_in "Name", with: "Ari Krakow"
        fill_in "Email", with: "arikrak@gmail.com"
        fill_in "Password", with: "zyx789"
        fill_in "Confirmation", with: "zyx789"
      end

      it "should create user" do
        expect{click_button submit}.to change(User, :count).by(1)
      end

    end

  end


  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    let!(:m1) { FactoryGirl.create(:post, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:post, user: user, content: "Bar") }

    before { visit user_path(user) }

    it{ should have_selector('h1', text: user.name)}
    it{ should have_selector('title', text: user.name)}

    describe "posts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.posts.count) }
    end
  end

  describe "edit" do
    let(:user) {FactoryGirl.create(:user)}
    before { visit edit_user_path(user)}

    describe "page" do
       it {should have_selector('h1', text: "Update profile")}
       it {should have_selector('title', text: "Edit user")}
       it {should have_link('change', href: 'http://gravatar.com/emails')}
    end

    describe "if invalid" do
      before {click_button"Save changes"}

      it {should have_content('error')}
    end

    #copying
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end


  end



end
