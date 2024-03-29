package Jobeet::Controller;
use Ark 'Controller';
use Jobeet::Models;

# default 404 handler
# 0.0.0.0:5000/xxxx/xxにマッチするアクションが他になかった場合、これが実行される
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}

#0.0.0.0:5000のURLにマッチする
sub index :Path :Args(0) {
    my ($self, $c) = @_;
    $c->res->body('Ark Default Index'); 
}

__PACKAGE__->meta->make_immutable;

#endは実行の最後に実行される
# PrivateはURLを対応しない
sub end :Private {
    my ($self, $c) = @_;
    # #$c->res->bodyがあればxxx.mtファイルがなくても良さそう
    unless ($c->res->body or $c->res->status =~ /^3\d\d/){
        # ビューに処理を配送する
        $c->forward( $c->view('MT'));
    }
}
