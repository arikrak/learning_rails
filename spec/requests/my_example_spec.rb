#require "rspec"     #instead  of spec_helper ?
require 'spec_helper'

 describe "static pages" do

describe "the home page" do

  it "have some content" do
    visit '/static_pages/home'
    page.should have_selector('title', :text=> "Ruby on Rails | Home" )
  end
end

describe "about page" do
   it "have about content" do
      visit '/static_pages/about'
      page.should have_selector('title', :text=> "Ruby on Rails | About" )
   end
end

describe "help page" do
  it "help content" do
    visit '/static_pages/help'
    page.should have_selector('title', :text=> "Ruby on Rails | Help" )
  end
end

   end