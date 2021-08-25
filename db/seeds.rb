# テスト用アカウントの生成
# 購入者用
User.create(
  email: 'buy@com',
  password: 'abc123', password_confirmation: 'abc123',
  nickname: 'さとう',
  last_name: '佐藤', first_name: '一郎',
  last_name_kana: 'サトウ', first_name_kana: 'イチロウ',
  birth_date: '2000-01-01',
)
# 出品者用
User.create(
  email: 'sell@com',
  password: 'abc123', password_confirmation: 'abc123',
  nickname: 'すずき',
  last_name: '鈴木', first_name: '次郎',
  last_name_kana: 'スズキ', first_name_kana: 'ジロウ',
  birth_date: '2000-01-01',
)
