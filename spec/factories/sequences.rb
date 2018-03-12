FactoryGirl.define do
  sequence :string do |n|
    "string-#{n}"
  end

  sequence :email do |n|
    "email#{n}@factory.com"
  end

  sequence :site_url do |n|
    "http://site-#{n}"
  end

  sequence :path do |n|
    "/path-#{n}"
  end

  sequence :name do |n|
    "Name #{n}"
  end
end
