# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create([{name: "소프트웨어학과"}, {name: "사이버보안학과"}]);

admin_user = User.create( email: 'admin@ajou.ac.kr', password: '12345678', confirmed_at: Time.now )
admin_user.add_role :admin

User.create( email: 'test@ajou.ac.kr', password: '12345678', confirmed_at: Time.now )
User.create( email: 'pourmonreve@ajou.ac.kr', password: '12345678', confirmed_at: Time.now )
# User.create( email: 'test@ajou.ac.kr', password: '12345678', confirmed_at: Time.now )

