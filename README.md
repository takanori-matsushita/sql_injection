# sql_injection

1. sql-injection.sqlファイルのsqlを実行してデータベース環境を構築して下さい。
1. データベース接続の設定を適宜編集して下さい。(デフォルトではpostgreSQLを使用)
1. 以下のID・パスワードでログインして下さい。
ユーザーID：hacker
パスワード：hacker

## SQLインジェクションの内容
app.rbの検索フォームSQL文(72行目)  
`@searchs = client.exec_params("select title, content, date from posts where title like '%#{params[:search]}%' or content like '%#{params[:search]}%'")`

### テーブルのデータをすべて削除する
以下のコードをコピーして検索フォームへ貼り付けし、検索して下さい。  
`'; truncate table posts; --`

以下のようにSQL文として解釈されてしまう  
`select title, content, date from posts where title like '%'; truncate table posts; --%' or content like '%#{params[:search]}%'`

### ユーザーIDとパスワードを表示する
以下のコードをコピーして検索フォームへ貼り付けし、検索して下さい。  
`' union select userid, password, current_date from users; --`

以下のようにSQL文として解釈されてしまう  
`select title, content, date from posts where title like '%' union select userid, password, current_date from users; --%' or content like '%#{params[:search]}%'`

## SQLインジェクション対策
検索フォームのSQL文(72行目)を以下のように修正して下さい。
`@searchs = client.exec_params("select title, content, date from posts where title like $1 or content like $1",["%#{params[:search]}%"])`

## gem
- sinatra  
- pg  
