namespace :dev do
  task fake_user: :environment do
    User.destroy_all

    User.create(
      email: "admin@example.com", 
      password: "12345678",
      name: "admin", 
      role: "admin",
      introduction: FFaker::Lorem.sentence(15)
      )
    puts "Default admin created!"

    20.times do |i|
      user_name = FFaker::Name.first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      user = User.create!(
        email: "#{user_name}@example.com",
        password: "12345678",
        name: "#{user_name}",
        introduction: FFaker::Lorem.sentence(15),
        avatar: file
      )

      user.save!

    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_post: :environment do
    Post.destroy_all

    User.all.each do |user|
      rand(2..5).times do |i|
         user.posts.create!(
          title: FFaker::Lorem::sentence(2),
          description: FFaker::Lorem::sentence(10),
          category: Category.all.sample
        )
      end
    end

    puts "have created fake posts"
    puts "now you have #{Post.count} posts data"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Post.all.each do |post|
      rand(2..4).times do |i|
        post.replies.create!(
          comment: FFaker::Lorem.sentence(10),
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} reply data"
  end

end
