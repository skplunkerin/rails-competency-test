# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# TEST USERS
pass =  'Tuna123!'
u1 = User.create({email: 'tuna@example.com', password: pass})
if u1.errors.empty?
  p '=== USER CREATED ==='
  puts "\tEmail: #{u1.email}"
  puts "\tPass: #{pass}"
else
  p '=== USER ERRORS ==='
  puts "\t" + u1.errors.full_messages.to_sentence
  puts "\tEmail: #{u1.email}"
  puts "\tPass: #{pass}"
  # Find user (used below)
  u1 = User.find_by_email('tuna@example.com')
end
p '======'
# END USERS

# TEST ARTICLES
[
  {
    user_id: u1.id,
    title: "Test article 1",
    category: "category_1",
    content: "<p>This is a paragraph. This is a paragraph. This is a paragraph. This is a paragraph.</p><p>This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two.</p><p>This is paragraph three. This is paragraph three. This is paragraph three. This is paragraph three.</p>"
  },
  {
    user_id: u1.id,
    title: "Test article Two",
    category: "category_2",
    content: "<p>This is a paragraph. This is a paragraph. This is a paragraph. This is a paragraph.</p><p>This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two.</p><p>This is paragraph three. This is paragraph three. This is paragraph three. This is paragraph three.</p>"
  },
  {
    user_id: u1.id,
    title: "Test article 3",
    category: "category_1",
    content: "<p>This is a paragraph. This is a paragraph. This is a paragraph. This is a paragraph.</p><p>This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two.</p><p>This is paragraph three. This is paragraph three. This is paragraph three. This is paragraph three.</p>"
  },
  {
    user_id: u1.id,
    title: "Test article Number Four",
    category: "category_2",
    content: "<p>This is a paragraph. This is a paragraph. This is a paragraph. This is a paragraph.</p><p>This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two. This is paragraph two.</p><p>This is paragraph three. This is paragraph three. This is paragraph three. This is paragraph three.</p>"
  }
].each do |a|
  a1 = Article.create(a)
  if a1.errors.empty?
    p '=== ARTICLE CREATED ==='
    puts "\tTitle: #{a1.title}"
    puts "\tCategory: #{a1.category}"
  else
    p '=== ARTICLE ERRORS ==='
    puts "\t" + a1.errors.full_messages.to_sentence
    puts "\tTitle: #{a1.title}"
    puts "\tCategory: #{a1.category}"
  end
end
p '======'
# END ARTICLES
