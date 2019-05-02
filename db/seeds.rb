User.create!(
  name: "Admin",
  email: "lyld1203@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1,
  phone: "0123456789",
  activated: true,
  activated_at: Time.zone.now
)

User.create!(
  name: "Linh",
  email: "abc@gmail.com",
  password: "asdasd",
  password_confirmation: "asdasd",
  role: 1,
  phone: "02156446846",
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  phone = Faker::PhoneNumber.cell_phone
  password = "password"
  User.create!(
    name: name,
    email: email,
    role: 2,
    phone: phone,
    password: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

# Category Seed
Category.create!(
  name: "Fast Food",
  parent_id: nil
)

Category.create!(
  name: "Bread",
  parent_id: nil
)

Category.create!(
  name: "Noodles",
  parent_id: nil
)

Category.create!(
  name: "Meat",
  parent_id: nil
)

# Product Seed
20.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    information: Faker::Lorem.paragraph(5),
    image: Rails.root.join("app/assets/images/fast-food.png").open,
    classify: true,
    quantity: Faker::Number.between(1, 90),
    category_id: 1
  )
end

3.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    information: Faker::Lorem.paragraph(5),
    image: Rails.root.join("app/assets/images/noodles.png").open,
    classify: true,
    quantity: Faker::Number.between(1, 90),
    category_id: 3
  )
end

10.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    information: Faker::Lorem.paragraph(5),
    image: Rails.root.join("app/assets/images/bread.jpg").open,
    classify: false,
    quantity: Faker::Number.between(1, 90),
    category_id: 2
  )
end

6.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    information: Faker::Lorem.paragraph(5),
    image: Rails.root.join("app/assets/images/1.jpg").open,
    classify: false,
    quantity: Faker::Number.between(1, 90),
    category_id: 4
  )
end

#Comment seed
3.times do
  Comment.create!(
    content: Faker::Lorem.sentence(5),
    rating: Faker::Number.between(1, 5),
    user_id: 1,
    product_id: 1
  )
end

3.times do
  Comment.create!(
    content: Faker::Lorem.sentence(5),
    rating: Faker::Number.between(1, 5),
    user_id: 2,
    product_id: 2
  )
end
