#!/bin/bash

# Create temporary file
TMPFILE=$(mktemp)

# Copy the common XML file
echo "Generating Jenkins config file..."
jjj -c etc/supermario/supermario.json templates/mainconfig.xml.mako > ${TMPFILE}
cp ${TMPFILE} /var/lib/jenkins/config.xml

# Copy all the available jobs
jobs[1]="SuperMario_00_Build_And_Run_Unit_Tests"
jobs[2]="SuperMario_10_Upload_Debian_Package"
jobs[3]="SuperMario_20_Deploy_To_Testing"
jobs[4]="SuperMario_30_System_Test_In_Testing"

NUMBER_OF_JOBS=${#jobs[@]}

for index in {1..4}
do
    echo "Generating Jenkins job: ${jobs[index]}..."
    jjj -v "name=${jobs[index]}" -l ${PWD}/templates/supermario/jobs/${jobs[index]} -c etc/supermario/supermario.json templates/jobconfig.xml.mako > ${TMPFILE}
    mkdir -p /var/lib/jenkins/jobs/${jobs[index]}/
    cp ${TMPFILE} /var/lib/jenkins/jobs/${jobs[index]}/config.xml
    echo "Generation of Jenkins job done! (${jobs[index]})"
done





# jjj -v 'name=SuperMario_00_Build_And_Run_Unit_Tests' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_00_Build_And_Run_Unit_Tests/config.xml.mako > /tmp/SM00.xml
# jjj -v 'name=SuperMario_10_Upload_Debian_Package' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_10_Upload_Debian_Package/config.xml.mako > /tmp/SM10.xml
# jjj -v 'name=SuperMario_20_Deploy_To_Testing' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_20_Deploy_To_Testing/config.xml.mako > /tmp/SM20.xml
# jjj -v 'name=SuperMario_30_System_Test_In_Testing' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_30_System_Test_In_Testing/config.xml.mako > /tmp/SM30.xml

