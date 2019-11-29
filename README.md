# README

## future⇀me
future⇀meは過去の自分に対して、アドバイスを投稿できるアプリです。転職活動用のポートフォリオとして作成致しました。

## ポートフォリオ URL
https://future-me7.com

ホーム画面からテストユーザーとしてログインが可能です。

## 機能一覧、使用gemなど
* ユーザー登録、ログイン機能(session, cookie)
* ユーザー間でのフォロー、フォロワー機能(ajax)
* ユーザー間のチャットルーム機能(ajax)
* ツイート投稿機能(CRUD)
* 画像投稿機能(carrierwave)
* ハッシュタグ検出・一覧表示機能(正規表現)
* URLのリンク化(rinku)
* いいね機能(ajax)
* ツイートへのコメント機能(ajax)
* ページネーション機能(kaminari)
* 直近１ヶ月のいいね数ランキング機能
* 管理者機能（activeadmin, devise）
* ユーザー名、コメントの詳細検索及びソート機能(ransack)
* ソーシャルシェア機能
* レスポンシブデザイン(bootstrap)

## 使用技術
* Ruby 2.6.5
* Ruby on Rails 5.2.3
* MySQL 5.7
* bootstrap, sass 
* Docker, docker-compose
* Rspec
* AWS
  * ECS
  * ECR 
  * EC2 
  * RDS(MySQL)
  * S3 
  * VPC
  * Route53
  * ACM
  * ALB
  * Cloudwatch
* CircleCI

## テスト
* Rspec
  * 単体テスト（model spec）
  * 統合テスト（system spec）

## CircleCI (ECS Orbs)
masterブランチへのpushにより、テスト→ビルド→デプロイの順でECSサービスの自動更新を行います。
最新のECS-Orbsを用いて、config.ymlを簡潔に記述しました。

# AWSアーキテクチャ図
![awsのアーキテクチャ図](./aws-arc-image.png)