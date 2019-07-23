package Jobeet::Schema;
use v5.16.3;
use strict;
use warnings;
use parent 'DBIx::Class::Schema';
use DateTime;

#これで、DBIx::Classは
# - Jobeet::Schema::Result::* - データベースのテーブルを表すクラス、テーブルと1対1
# - Jobeet::Schema::ResultSet::* - 同名のResult暮らさうの集合を表すクラス、SQLクエリの結果
#のネームスペースにあるコードを自動ロードします。
__PACKAGE__->load_namespaces;

sub TZ{state $TZ = DateTime::TimeZone->new(name => 'Asia/Tokyo')}
sub now {DateTime->now((time_zone => shift->TZ, locale => 'ja'))}
sub today {shift->now->truncate(to => 'day')}

1;
