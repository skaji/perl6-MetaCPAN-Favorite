#!/usr/bin/env perl6
use v6;
use lib "lib", "../lib";
use MetaCPAN::Favorite;

my $metacpan = MetaCPAN::Favorite.new(cache => "./cache.txt");
my $favorite = Supply.interval(60).map({ $metacpan.Supply }).flat;

sub tweet($msg) { note $msg }

react {
    whenever $favorite -> %fav {
        my $name = %fav<name>; # Plack
        my $user = %fav<user>; # SKAJI (the user who favorites Plack, can be undef)
        my $date = %fav<date>; # 2016-08-05T07:49:15.000Z
        my $url  = %fav<url>;  # https://metacpan.org/release/Plack
        $user //= "anonymous";

        tweet("$name++ by $user, $url"); # or, whatever you want
    };
};
