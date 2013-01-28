# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActivityType.create(title: 'walking', description: 'moving using your own feets')
ActivityType.create(title: 'cycling', description: 'moving using bicycle')
ActivityType.create(title: 'swimming', description: 'moving in water using your legs and arms')

User.create(email: 'petr24616@seznam.cz', password:'petrpetr', password_confirmation:'petrpetr')
Route.create(user_id: 1, title: 'prvni cesta', description: 'hezka prvni cesta', map: 'xyz 12.435,2352', activity_type_id: 1)
Route.create(user_id: 1, title: 'druha cesta', description: 'hnusna druha cesta', map: 'zyx 12.435,2352', activity_type_id: 1)

RouteActivityRelation.create(route_id: 1, activity_type_id: 1)
RouteActivityRelation.create(route_id: 1, activity_type_id: 2)
RouteActivityRelation.create(route_id: 2, activity_type_id: 3)

