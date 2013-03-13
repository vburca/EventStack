# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    majors = [ "American Studies", "Anthropology", "Art History", "Biochemistry",
               "Biology", "Chemistry", "Classical Civilization", "Classics",
               "Computer Science", "Economics", "Educational Studies", "Engineering",
               "English", "Environmental Science", "French Studies", "German Studies",
               "Hispanic Studies", "History", "Interdisciplinary Computing", "International Studies",
               "Italian Studies", "Jewish Studies", "Arabic", "Chinese",
               "Hebrew", "Japanese", "Mathematics", "Music",
               "Neuroscience", "Phylosophy", "Physics", "Political Science",
               "Psychology", "Public Policy and Law", "Religion", "Russian",
               "Sociology", "Studio Arts", "Theater and Dance", "Women, Gender, and Sexuality" ]

    majors.each do |major|
      Major.create(name: major)
    end