require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '入力内容に問題がなければ登録できること' do
      expect(@user).to be_valid
    end

    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      @user.save
      user2 = FactoryBot.build(:user, email: @user.email)
      user2.valid?
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'test.sample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字以上であれば登録できること' do
      @user.password = 'abc456'
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end
    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = 'abc45'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英字だけでは登録できないこと' do
      @user.password = 'abcdef'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end
    it 'passwordが半角数字だけでは登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end
    it 'passwordに全角を含むと登録できないこと' do
      @user.password = 'aｂｃ１２3'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = 'abc456'
      @user.password_confirmation = 'abc4567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前(全角)は、名字が必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'お名前(全角)は、名前が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'お名前(全角)は、名字に半角を含むと登録できないこと' do
      @user.last_name = '漢ｱｲｳｴｵ字'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
    end
    it 'お名前(全角)は、名前に半角を含むと登録できないこと' do
      @user.first_name = '漢ｱｲｳｴｵ字'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
    end
    it 'お名前(全角)は、名字に全角英字を含むと登録できないこと' do
      @user.last_name = '漢ＡＢＣ字'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
    end
    it 'お名前(全角)は、名前に全角英字を含むと登録できないこと' do
      @user.first_name = '漢ＡＢＣ字'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
    end

    it 'お名前カナ(全角)は、名字が必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'お名前カナ(全角)は、名前が必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'お名前カナ(全角)は、名字に半角を含むと登録できないこと' do
      @user.last_name_kana = '漢ｱｲｳｴｵ字'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名前に半角を含むと登録できないこと' do
      @user.first_name_kana = '漢ｱｲｳｴｵ字'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名字に全角漢字を含むと登録できないこと' do
      @user.last_name_kana = 'アイウ漢字エオ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名前に全角漢字を含むと登録できないこと' do
      @user.first_name_kana = 'アイウ漢字エオ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名字に全角ひらがなを含むと登録できないこと' do
      @user.last_name_kana = 'アイウあいうえおエオ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名前に全角ひらがなを含むと登録できないこと' do
      @user.first_name_kana = 'アイウあいうえおエオ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名字に全角英字を含むと登録できないこと' do
      @user.last_name_kana = 'アイウＡＢＣエオ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
    end
    it 'お名前カナ(全角)は、名前に全角英字を含むと登録できないこと' do
      @user.first_name_kana = 'アイウＡＢＣエオ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
    end

    it '生年月日が必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
