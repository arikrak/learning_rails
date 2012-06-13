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
    before { visit user_path(user) }

    it{ should have_selector('h1', text: user.name)}
    it{ should have_selector('title', text: user.name)}
  end

end
