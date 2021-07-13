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

## itemsテーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| name                | string     | null: false |
| info                | text       | null: false |
| category            | references | null: false, foreign_key: true |
| sales_status        | references | null: false, foreign_key: true |
| shipping_fee_status | references | null: false, foreign_key: true |
| prefecture          | references | null: false, foreign_key: true |
| scheduled_delivery  | references | null: false, foreign_key: true |
| price               | integer    | null: false |
| user                | references | null: false, foreign_key: true |

# ordersテーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postal_code        | string     | null: false |
| prefecture         | references | null: false, foreign_key: true |
| city               | string     | null: false, foreign_key: true |
| addresses          | string     | null: false, foreign_key: true |
| building           | string     | null: false, foreign_key: true |
| phone_number       | string     | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |
