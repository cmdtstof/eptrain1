#!/usr/bin/perl -w -I/opt/eprints3/perl_lib
# Search for eprints by date

#use EPrints::Session;
use EPrints;
use strict;

# Check we got 2 args
# The data arg can take several forms e.g: 
# "2000", "1990-", "2003-2005"
# "2003-07-04-2005-06-02", "-1976-12-25"
if( scalar @ARGV != 2 )
{
	print "Usage: $0 archiveid date|daterange\n";
	exit;
}
my $archiveid = $ARGV[0];
my $daterange = $ARGV[1];

# Start session
my $session = new EPrints::Session( 1, $archiveid );
exit( 0 ) unless( defined $session );

# Get archive dataset
my $ds = $session->get_archive()->get_dataset( "archive" );

# Create search expression
my $searchexp = new EPrints::SearchExpression( 
			session=>$session, 
			dataset=>$ds );

# Add filter
$searchexp->add_field(
	$ds->get_field( "date_effective" ),
	$daterange,
	"EQ",
	"ALL" );

$searchexp->perform_search;

# Get ids of matching eprints
# Note get_ids returns a reference to an array
my $ids = $searchexp->get_ids; 
print join( ",",@{$ids} )."\n";

# Tidy up
$searchexp->dispose();

# End session
$session->terminate();
