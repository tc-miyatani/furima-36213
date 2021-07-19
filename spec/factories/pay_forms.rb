FactoryBot.define do
  factory :pay_form do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '北海道' }
    addresses { '1-1-1' }
    building { 'アパート101' }
    phone_number { '08012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
