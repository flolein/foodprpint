require "date"
require 'json'
require 'open-uri'

# destroying all producers, products, offerings and posts
puts "Destroying all Offerings"
Offering.destroy_all

puts "Destroying all Products"
Product.destroy_all

puts "Destroying all Producers"
Producer.destroy_all

puts "Destroying all Posts"
Post.destroy_all

# creating all products from google spreadheet
puts "Creating products..."

product_url = 'https://spreadsheets.google.com/feeds/list/10-q-j1EiK1OkI6ibLB631vhkcJRY0jN6CWd0Sa-EbSU/od6/public/values?alt=json'
product_seed_url = open(product_url).read
product_seed_json = JSON.parse(product_seed_url)

product_seed_json['feed']['entry'].each do |seed|
  product = Product.new(
    name:  seed['gsx$name']['$t'],
    category: seed['gsx$category']['$t'],
    season_start: seed['gsx$seasonstart']['$t'].to_i,
    season_end: seed['gsx$seasonend']['$t'].to_i,
    content: seed['gsx$content']['$t'],
    fact1: seed['gsx$fact1']['$t'],
    fact2: seed['gsx$fact2']['$t'],
    fact3: seed['gsx$fact3']['$t'],
    photo: "https://res.cloudinary.com/teamleia/image/upload/v1583844346/foodprint/products/#{seed['gsx$photo']['$t']}.jpg"
  )
  product.save!
end

puts "Successfully created products. Easy!"

# creating all producers from google spreadheet
puts "Creating producers..."

producer_url = 'https://spreadsheets.google.com/feeds/list/1cp9Hw1rSBGOowGiHmZlhmxL3qKpK0JhXCbgSxzDiX8Y/od6/public/values?alt=json'
producer_seed_url = open(producer_url).read
producer_seed_json = JSON.parse(producer_seed_url)

producer_seed_json['feed']['entry'].each do |seed|
  producer = Producer.new(
    company_name:  seed['gsx$companyname']['$t'],
    owner_name: seed['gsx$ownername']['$t'],
    city: seed['gsx$city']['$t'],
    street: seed['gsx$street']['$t'],
    region: seed['gsx$region']['$t'],
    address: seed['gsx$address']['$t'],
    description: seed['gsx$description']['$t'],
    website: seed['gsx$website']['$t'],
    photo: "https://res.cloudinary.com/teamleia/image/upload/v1583842494/foodprint/producer/#{seed['gsx$photo']['$t']}.jpg"
  )
  producer.save!
end

puts "Successfully created producers. Easy!"

# creating all offerings from google spreadheet
puts "Creating offerings..."

offering_url = 'https://spreadsheets.google.com/feeds/list/1PEmFNI90K3aenAPgM1qseBjqIcRxxVAwNTPDDGvGOQs/od6/public/values?alt=json'
offering_seed_url = open(offering_url).read
offering_seed_json = JSON.parse(offering_seed_url)

offering_seed_json['feed']['entry'].each do |seed|
  offering = Offering.new(
    product:  Product.where('name = ?', seed['gsx$productname']['$t']).first,
    producer: Producer.where('company_name = ?', seed['gsx$producername']['$t']).first
  )
  offering.save!
end

# creating all posts from google spreadheet
puts "Creating posts..."

post_url = 'https://spreadsheets.google.com/feeds/list/1Q9NDVecKOzgidp_4jVtVSCqAbqT1DMLxer6FC0AvZVs/od6/public/values?alt=json'
post_seed_url = open(post_url).read
post_seed_json = JSON.parse(post_seed_url)

post_seed_json['feed']['entry'].each do |seed|
  post = Post.new(
    producer: Producer.where('company_name = ?', seed['gsx$producername']['$t']).first,
    post_type: seed['gsx$posttype']['$t'],
    title: seed['gsx$title']['$t'],
    content: seed['gsx$content']['$t'],
    address: seed['gsx$address']['$t'],
    photo: "https://res.cloudinary.com/teamleia/image/upload/v1583497876/foodprint/posts/#{seed['gsx$photo']['$t']}.jpg"
  )
  post.save!
end

puts "Successfully created posts. Easy!"

puts Product.first['category']
puts Product.first['season_start']
puts Product.last['name']
puts Product.last['season_end']
puts Producer.last['city']
puts Producer.last['photo']

puts Post.last['title']
