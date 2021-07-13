FactoryBot.define do
  factory :user do
    transient do
      person {Gimei.name}
    end
    email {Faker::Internet.free_email}
    password {Faker::Lorem.characters(number: rand(6..128), min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    nickname {Faker::Name.last_name}
    last_name {person.last.kanji}
    first_name {person.first.kanji}
    last_name_kana {person.last.katakana}
    first_name_kana {person.first.katakana}
    birth_date {Faker::Date.birthday(min_age: 5, max_age: 90).strftime('%Y-%m-%d')}
  end
end
