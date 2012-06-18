require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}

  describe "signin page" do
    before {visit signin_path}

     describe "if invalid info" do
         before { click_button 'Sign in'}

       it {should have_selector('title', text: 'Sign in') }
       it { should have_selector('div.alert.alert-error', text: 'Invalid')}

         describe "next page" do
           before { click_link "Home" }
           it { should_not have_selector('div.alert.alert-error') }
         end

     end

     describe "if valid info" do
        let(:user) {FactoryGirl.create(:user)}
       before do
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
       end

       #now check new page
        it {should have_selector('title', text: user.name) }
        it {should_not have_link('Sign in', href: signin_path)}
        it{should have_link('Sign out', href: signout_path )}
        it {should have_link('Profile', href: user_path(user))}

       describe "if then logout" do
         before {click_link "Sign out"}
         it {should have_link "Sign in"}
       end

     end

            #c
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Edit user') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end


    #tests for redirect**
    #place in section
    describe "for non-signed-in" do
       let(:user) {FactoryGirl.create(:user)}

      describe "try visit protected page" do
        before do
           visit edit_user_path(user)
           fill_in "Email",    with: user.email
           fill_in "Password", with: user.password
           click_button "Sign in"
        end
         describe "after signin" do
            it "should render right page" do
              page.should  have_selector('title', text: "Edit user")
            end
         end
      end


      describe "visit user index" do
          before { visit users_path}
          it {should have_selector(text: 'Sign in')}
      end

    end


  end
end
