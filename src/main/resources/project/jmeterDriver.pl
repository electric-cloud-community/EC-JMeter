# -------------------------------------------------------------------------
# Package
#    jmeterDriver.pl
# Dependencies
#    None
#
# Purpose
#    Use JMeter tool features on Electric Commander
#
# Plugin Version
#    2.0.2
#
# Date
#    18/01/2011
#
# Engineer
#    Brian Nelson   
#
# Copyright (c) 2012 Electric Cloud, Inc.
# All rights reserved
# -------------------------------------------------------------------------
   
   
# -------------------------------------------------------------------------
# Includes
# -------------------------------------------------------------------------
use strict;
use warnings;
use ElectricCommander;

$|=1;

# -------------------------------------------------------------------------
# Variables
# -------------------------------------------------------------------------
my $ec = new ElectricCommander();
$ec->abortOnError(0);
  
$::gServer              = $ec->getProperty("/myCall/server")->findvalue("//value")->value();
$::gAdditionalOptions   = $ec->getProperty("/myCall/additionalOptions")->findvalue("//value")->value();
$::gLogFile             = $ec->getProperty("/myCall/logFile")->findvalue("//value")->value();
$::jmFile               = $ec->getProperty("/myCall/jmeterFile")->findvalue("//value")->value();

#-------------------------------------------------------------------------
# main - contains the whole process to be done by the plugin, it builds 
#        the command line, sets the properties and the working directory
#
# Arguments:
#   -none
#
# Returns:
#   -nothing
#
#-------------------------------------------------------------------------
sub main() {
    
    # create args array
    my @args = ();
    
    push(@args, "jmeter -n");
    
    #Set the jmeter file    
    if($::jmFile && $::jmFile ne " ") {
          push(@args, '-t '.'"'.$::jmFile.'"');
          
     }     

     #Set the log file  
    if($::gLogFile && $::gLogFile ne " ") {
        push(@args, '-l '.$::gLogFile);
       
    }
  
     
    #Set a remote server for JMeter to use
    if($::gServer && $::gServer ne " ") {
        push(@args,'-R '.$::gServer);
       
    }
  
    #Additional options can be added to the jmeter command
    if($::gAdditionalOptions  && $::gAdditionalOptions  ne " ") {
        foreach my $command (split(' ',$::gAdditionalOptions)) {
            push(@args, $command);
        }
    }

    # get an EC object
    my $ec = new ElectricCommander();
    $ec->abortOnError(0);
    
    $ec->setProperty("/myCall/commandLine", join(" ",@args));
}

main();
