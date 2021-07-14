require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.user.save
  end

  it '入力内容に問題がなければ出品できること' do
    expect(@item).to be_valid
  end

  it '商品画像を1枚つけることが必須であること' do
    @item.image = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Image can't be blank")
  end

  it '商品名が必須であること' do
    @item.name = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Name can't be blank")
  end

  it '商品の説明が必須であること' do
    @item.info = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Info can't be blank")
  end

  it 'カテゴリーの情報が必須であること' do
    @item.category_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Category can't be blank")
  end

  it 'カテゴリーの値は0ではいけないこと' do
    @item.category_id = 0
    @item.valid?
    expect(@item.errors.full_messages).to include("Category can't be blank")
  end

  it '商品の状態の情報が必須であること' do
    @item.sales_status_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Sales status can't be blank")
  end

  it '商品の状態の値は0ではいけないこと' do
    @item.sales_status_id = 0
    @item.valid?
    expect(@item.errors.full_messages).to include("Sales status can't be blank")
  end

  it '配送料の負担の情報が必須であること' do
    @item.shipping_fee_status_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
  end

  it '配送料の負担の値は0ではいけないこと' do
    @item.shipping_fee_status_id = 0
    @item.valid?
    expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
  end

  it '発送元の地域の情報が必須であること' do
    @item.prefecture_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Prefecture can't be blank")
  end

  it '発送元の地域の値は0ではいけないこと' do
    @item.prefecture_id = 0
    @item.valid?
    expect(@item.errors.full_messages).to include("Prefecture can't be blank")
  end

  it '発送までの日数の情報が必須であること' do
    @item.scheduled_delivery_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
  end
  it '発送までの日数の値は0ではいけないこと' do
    @item.scheduled_delivery_id = 0
    @item.valid?
    expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
  end

  it '価格の情報が必須であること' do
    @item.price = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Price can't be blank")
  end

  it '価格が¥300だと出品できること' do
    @item.price = 300
    expect(@item).to be_valid
  end

  it '価格が¥300未満だと出品できないこと' do
    @item.price = 299
    @item.valid?
    expect(@item.errors.full_messages).to include('Price is out of setting range')
  end

  it '価格が¥9999999だと出品できること' do
    @item.price = 9_999_999
    expect(@item).to be_valid
  end

  it '価格が¥9999999超だと出品できないこと' do
    @item.price = 10_000_000
    @item.valid?
    expect(@item.errors.full_messages).to include('Price is out of setting range')
  end

  it '価格に全角数値を含むと出品できないこと' do
    @item.price = '1２３４5'
    @item.valid?
    expect(@item.errors.full_messages).to include('Price before type cast is invalid. Input half-width characters')
  end
end
