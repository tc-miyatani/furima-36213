# テーブル設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

Association
has_many :items
has_many :orders

## itemsテーブル

| Column                 | Type       | Options     |
| ---------------------- | ---------- | ----------- |
| name                   | string     | null: false |
| info                   | text       | null: false |
| category_id            | integer    | null: false |
| sales_status_id        | integer    | null: false |
| shipping_fee_status_id | integer    | null: false |
| prefecture_id          | integer    | null: false |
| scheduled_delivery_id  | integer    | null: false |
| price                  | integer    | null: false |
| user                   | references | null: false, foreign_key: true |

belongs_to :user
has_one    :order

# ordersテーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

Association
belongs_to :item
belongs_to :user
has_one    :shipping_info

# shipping_infosテーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postal_code        | string     | null: false |
| prefecture_id      | integer    | null: false |
| city               | string     | null: false |
| addresses          | string     | null: false, foreign_key: true |
| building           | string     | null: false, foreign_key: true |
| phone_number       | string     | null: false, foreign_key: true |
| order              | references | null: false, foreign_key: true |

Association
belongs_to :order
