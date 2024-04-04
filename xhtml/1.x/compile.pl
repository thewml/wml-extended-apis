#!/usr/bin/perl

use strict;
use warnings;

use Template;

my @filenames = ("std/toc/toc");

sub get_file_mtime
{
    my $path = shift;

    return ( stat($path) )[9];
}

foreach my $fn (@filenames)
{
    my $wml_fn     = "$fn.wml";
    my $wml_source = "$wml_fn.tt2";
    my $src_mtime  = get_file_mtime($wml_source);
    my $dest_mtime = get_file_mtime($wml_fn);
    if (   ( !-e $wml_fn )
        || ( $src_mtime > $dest_mtime ) )
    {
        my $t = Template->new();
        $t->process( $wml_source, +{}, $wml_fn );
    }
}
