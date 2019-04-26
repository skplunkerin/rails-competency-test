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
end
p '======'
# END USERS

# TEST ARTICLES
# TODO
# END ARTICLES
