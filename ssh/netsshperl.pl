#!/usr/bin/perl
#http://www.perlhowto.com/execute_commands_on_remote_machines_using_ssh (31.07.13) 

use Net::SSH::Perl;
 
my $host = "stof005";
my $user = "test";
my $password = "tset";
 
#-- set up a new connection
my $ssh = Net::SSH::Perl->new($host);
#-- authenticate
$ssh->login($user, $pass);
#-- execute the command
my($stdout, $stderr, $exit) = $ssh->cmd("ls -l /home/$user");
print "$stdout\n";
