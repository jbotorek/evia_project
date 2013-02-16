# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActivityType.create(title: 'hiking', description: 'moving using your own feets')
ActivityType.create(title: 'cycling', description: 'moving using bicycle')
ActivityType.create(title: 'swimming', description: 'moving in water using your legs and arms')
ActivityType.create(title: 'cross-country skiing', description: 'moving on snow using skis')
ActivityType.create(title: 'roller skates', description: 'moving on roller skates')
ActivityType.create(title: 'running', description: 'run,run,run...')

User.create(email: 'petr24616@seznam.cz', password:'petrpetr', password_confirmation:'petrpetr')


