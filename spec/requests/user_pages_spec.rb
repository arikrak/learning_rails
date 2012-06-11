require 'spec_helper'

describe "UserPages" do

  subject{page}

  describe "signup page" do
    it{ should have_selector('title', text: "Sign Up")  } #can also check for "rails"
    it{ should have_selector('h1', text: "Sign up" )  }
  end

end
