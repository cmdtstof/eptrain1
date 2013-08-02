#!/usr/bin/perl -w -I/opt/eprints3/perl_lib
# Deposit an eprint in the archive


#Called deprecated function EPrints::EPrint::create !!!!!!!
#not working on 3.4.9



use EPrints;
use strict;

# Start session
my $session = new EPrints::Session( 1, "eprints1" );
exit( 0 ) unless( defined $session );

# Get archive dataset
my $dataset = $session->get_archive->get_dataset( "archive" );

# Create new eprint
#Called deprecated function EPrints::EPrint::create !!!!!!!
my $eprint = EPrints::EPrint::create( $session, $dataset );



$eprint->datestamp();
$eprint->set_value( "title", "Hello World" );
$eprint->set_value( "creators", 
	[ 
		{ main=>{ family=>"Smith", given=>"John" } },
		{ main=>{ family=>"Jones", given=>"Mary" } },
	] );
$eprint->set_value( "date_issue", "2005-02-02" );
$eprint->set_value( "type", "article" );
$eprint->commit();

# Add document to eprint
my $pdf;
my $filename = "demo.pdf";
if( open( $pdf, $filename ) )
{
	my $doc = EPrints::Document::create( $session, $eprint );
	$doc->set_value( 'format','pdf');
	$doc->upload( $pdf, 'paper.pdf' );
	close $pdf;
	$doc->set_value( 'main','paper.pdf');
	$doc->commit();
}
else
{
	print STDERR "Failed to open file: $filename: $!\n";
	print STDERR "Did not create document.\n";
}

# Generate abstract page for new eprint
$eprint->generate_static;

print "Created EPrint #".$eprint->get_id."\n";

# End session
$session->terminate();
