#!/usr/bin/perl ­w ­I/opt/eprints3/perl_lib
# Print the title of an eprint

use EPrints;
use strict;

# Check that we got 2 args
if( scalar @ARGV != 2 )
{
print "Usage: $0 repositoryid eprintid\n";
exit;
}

my $repositoryid = $ARGV[0];
my $eprintid = $ARGV[1];

# Start session
my $session = new EPrints::Session( 1, $repositoryid );
exit( 0 ) unless( defined $session );

# Try creating eprint
my $eprint = EPrints::DataObj::EPrint­>new( $session, $eprintid );
if( !defined $eprint )
{
print "$eprintid not found.\n";
}
else
{
print $eprint­>get_value( "title" )."\n";
}

# End Session
$session­>terminate();
 
