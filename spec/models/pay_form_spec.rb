require 'rails_helper'

RSpec.describe PayForm, type: :model do
  describe '商品購入' do
    before(:all) do
      # before(:each)に含めるとsleep入れないと途中でMysql2ConnectionErrorが起こる為
      @item = FactoryBot.create(:item)
      @user = FactoryBot.create(:user)
    end

    before(:each) do
      @pay_form = FactoryBot.build(
        :pay_form,
        item_id: @item.id, user_id: @user.id
      )
    end

    context '商品購入ができる時' do
      it '全て正しく入力されていれば商品が購入できること' do
        expect(@pay_form).to be_valid
      end

      it '建物名は任意であること' do
        @pay_form.building = ''
        expect(@pay_form).to be_valid
      end

      it '電話番号が10桁の半角数値のみだと購入できること' do
        @pay_form.phone_number = '0123456789'
        expect(@pay_form).to be_valid
      end

      it '電話番号が11桁の半角数値のみだと購入できること' do
        @pay_form.phone_number = '01234567890'
        expect(@pay_form).to be_valid
      end
    end

    context '商品購入ができない時' do
      it '郵便番号が必須であること' do
        @pay_form.postal_code = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が全角だと購入できないこと' do
        @pay_form.postal_code = '１２３−４５６７'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '郵便番号にハイフンが含まれていないと購入できないこと' do
        @pay_form.postal_code = '1234567'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '郵便番号に半角英字を含むと購入できないこと' do
        @pay_form.postal_code = '1a3−4567'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が必須であること' do
        @pay_form.prefecture_id = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県が0だと登録できないこと' do
        @pay_form.prefecture_id = 0
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が必須であること' do
        @pay_form.city = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        @pay_form.addresses = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Addresses can't be blank")
      end

      it '電話番号が必須であること' do
        @pay_form.phone_number = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が９桁だと購入できないこと' do
        @pay_form.phone_number = '123456789'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is too short')
      end

      it '電話番号が12桁だと購入できないこと' do
        @pay_form.phone_number = '012345678912'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is too long')
      end

      it '電話番号に全角数値を含むと購入できないこと' do
        @pay_form.phone_number = '01234５6789'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it '電話番号に英字を含むと購入できないこと' do
        @pay_form.phone_number = '01234a56789'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'itemが紐付いていないと購入できないこと' do
        @pay_form.item_id = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'userが紐付いていないと購入できないこと' do
        @pay_form.user_id = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("User can't be blank")
      end

      it 'payjpのtokenが空だと購入できないこと' do
        @pay_form.token = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
