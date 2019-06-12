# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :name do |n|
    "name#{n}"
  end
  sequence :title do |n|
    "title#{n}"
  end
end
