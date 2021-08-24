puts 'postのシードを実行します'

User.limit(10).each do |user|
  post = user.posts.create(body: "私は#{Faker::JapaneseMedia::Conan.character}だ！", remote_images_urls: %w[https://picsum.photos/id/237/200/300 https://picsum.photos/seed/picsum/200/300 ])
  puts "#{post.id}の投稿を作成した"
end
puts '投稿データの生成を完了しました'