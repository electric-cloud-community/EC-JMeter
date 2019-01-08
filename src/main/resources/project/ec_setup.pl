
# Data that drives the create step picker registration for this plugin.
my %runJMeter = (
    label       => "JMeter - Run JMeter",
    procedure   => "runJMeter",
    description => "Integrates JMeter Test Framework into Electric Commander",
    category    => "Test"

);

$batch->deleteProperty("/server/ec_customEditors/pickerStep/JMeter");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/JMeter - Run JMeter");

@::createStepPickerSteps = (\%runJMeter);
