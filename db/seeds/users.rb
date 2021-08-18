10.times do
User.create(username: Faker::JapaneseMedia::SwordArtOnline.game_name,
            email: Faker::Internet.email,
            password: 'sample',
            password_confirmation: 'sample'
)
end