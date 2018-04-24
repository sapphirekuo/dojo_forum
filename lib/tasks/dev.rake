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
end
