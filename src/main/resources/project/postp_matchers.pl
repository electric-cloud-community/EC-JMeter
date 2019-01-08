@::gMatchers = (
  {
   id =>        "testStarted",
   pattern =>          q{Starting the test @ (.+) \(},
   action =>           q{&addSimpleMessage("testStarted", "Test started at: $1");updateSummary();},
  },
  {
    id =>       "testCompleted",
    pattern =>         q{Tidying up ...    @ (.+) \(},
    action =>           q{&addSimpleMessage("testCompleted", "Test finished at : $1");updateSummary();},
  },
  {
    id =>       "FileErrors",
    pattern =>         q{Could not open (.*)},
    action =>           q{&addSimpleMessage("FileErrors", "Could not open $1");setProperty("outcome", "error" );updateSummary();},
  },
  {
    id =>       "GenericError",
    pattern =>          q{An error occurred: (.*) Press},
    action =>           q{&addSimpleMessage("GenericError", "Error: $1");setProperty("outcome", "error" );updateSummary();},
  },
  {
    id =>       "GenericError2",
    pattern =>          q{Error in (.*)},
    action =>           q{&addSimpleMessage("GenericError2", "Error in $1");setProperty("outcome", "error" );updateSummary();},
  },
  {
    id =>       "GenericError3",
    pattern =>          q{An error occurred: (.*)},
    action =>           q{&addSimpleMessage("GenericError3", "Error: $1");setProperty("outcome", "error" );updateSummary();},
  },
  {
    id =>       "ConnectionRefused",
    pattern =>          q{Connection refused},
    action =>           q{&addSimpleMessage("ConnectionRefused", "Connection refused");setProperty("outcome", "error" );updateSummary();},
  }
);

sub addSimpleMessage {
    my ($name, $customError) = @_;
    if(!defined $::gProperties{$name}){
        setProperty ($name, $customError);
    }
}

sub updateSummary() {
 
    my $summary = (defined $::gProperties{"testStarted"}) ? $::gProperties{"testStarted"} . "\n" : "";
    $summary .= (defined $::gProperties{"testCompleted"}) ? $::gProperties{"testCompleted"} . "\n" : "";
    $summary .= (defined $::gProperties{"FileErrors"}) ? $::gProperties{"FileErrors"} . "\n" : "";
    $summary .= (defined $::gProperties{"GenericError"}) ? $::gProperties{"GenericError"} . "\n" : "";
    $summary .= (defined $::gProperties{"GenericError2"}) ? $::gProperties{"GenericError2"} . "\n" : "";
    $summary .= (defined $::gProperties{"GenericError3"}) ? $::gProperties{"GenericError3"} . "\n" : "";
    $summary .= (defined $::gProperties{"ConnectionRefused"}) ? $::gProperties{"ConnectionRefused"} . "\n" : "";

    setProperty ("summary", $summary);
}


