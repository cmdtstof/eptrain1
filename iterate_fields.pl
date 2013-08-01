#!/usr/bin/perl -w -I/opt/eprints3/perl_lib
# Iterate over fields in a dataset

use EPrints;
use strict;

# Start session
my $session = new EPrints::Session( 1, "eprints1" );
exit( 0 ) unless( defined $session );

# Get archive dataset
#my $dataset = $session->get_repository->get_dataset( "archive" );
#my $dataset = $session->get_repository->get_dataset( "user" );
#my $dataset = $session->get_repository->get_dataset( "eprint" );
#my $dataset = $session->get_repository->get_dataset( "subject" );
#my $dataset = $session->get_repository->get_dataset( "document" );
#>>> unknown dataset!!! my $dataset = $session->get_repository->get_dataset( "subscription" );
my $dataset = $session->get_repository->get_dataset( "history" );

# Get list of fields in dataset
my @fields = $dataset->get_fields;

# Iterate over fields
foreach my $field ( @fields )
{
	print $field->get_name.": ".$field->get_type;
	if( $field->get_property( "multiple" ) )
	{
		print " (multiple)";
	}
	# Print "human-readable" field name
	print "... \"".EPrints::Utils::tree_to_utf8( $field->render_name( $session ) )."\"";
	print "\n";
}

# End session
$session->terminate();
