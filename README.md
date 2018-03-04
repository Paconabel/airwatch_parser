## AIRWATCH PARSER

This is a simple parser to extract from the Vmware AirWatch API response file to a csv with the following info: DeviceId, Udid, SerialNumber, EnrollmentUserName, AssetNumber, Uptime, iCloud, Battery Status, CPU, Hostname, Battery Cyclecount, Os minor build version


### RUN PARSER

To run the parser you will need Ruby installed in your device:
https://www.ruby-lang.org/en/documentation/installation/ or you can download a docker container with ruby. After that, you can run the parser following this instructions::

1.- Download the parser

2.- Get the info from your AirWatch API and paste to a json file (You have and example in the file.json)

3.- Run the parser in your console with: `ruby parseator.rb <filename>` (i.e. `ruby parseator.rb file.json`)

This should return a result.csv file in the parse_airwatch folder.


### RUN TEST

There is a unit test to test the parser. If you want to run the test, you will need to run `bundle install` in your console. This will install Rspec to test.

After that, you can run the test in your console with: `rspec`
