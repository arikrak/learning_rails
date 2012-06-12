#require "rspec"     #instead  of spec_helper ?
require 'spec_helper'

describe "static pages" do

  let(:btitle) {"Ruby on Rails"}
  subject {page}

  #shared_examples_for "all static pages" do
  #  #it{ should_have_selector('title', text: )}  #fill this one in..
  #  it{ should_have_selector('h1', text: heading)}
  #end

  describe "the home page" do
    before{visit root_path}
    it {should have_selector('title', text: btitle) }
    it {should have_selector('h1', text: "Snapple App")    }
  end

  describe "about page" do
    before{visit about_path}
    it{ should have_selector('title', text: "#{btitle} | About" )   }
    it{ should have_selector('h1', text: "about")}
  end

  describe "help page" do
    before{visit help_path}
    it{should have_selector('title', text: "#{btitle} | Help" )  }

  end

  describe "contact page" do
    before{ visit contact_path}
    it { should have_selector('title', text: "#{btitle} | Contact")  }

  end



end