namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
  end


  def make_users
    admin = User.create!(name: "Admin user",
                         email: "ak@zappable.com",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_posts
    users=User.all(limit:5)
    50.times do
      content=Faker::Lorem.sentence(5)
      users.each {|u| u.post.create!(content: content) }
    end
  end

  def make_relationships
    users= User.all
    user = User.first
    followed_users = users[2..40]
    followers= users[10..30]
    followed_users.each {|fu| user.follow!(fu) }
    followers.each {|fu| fu.follow!(user) }




  end







end