FactoryBot.define do
  factory :user do
    email {"dy.dev.test1@yopmail.com"}
    password {"12345678"}
  end

  factory :admin, class: 'User' do
    email {"dy.dev.admin1@yopmail.com"}
    password {"12345678"}
    role { :admin }
  end
end