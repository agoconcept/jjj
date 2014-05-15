#!/bin/bash

# This is a just a simple way of comparing generated XMLs with provided XMLs
# TODO: Move this to actual tests that are run by nosetests

jjj -v 'name=SuperMario_00_Build_And_Run_Unit_Tests' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_00_Build_And_Run_Unit_Tests/config.xml.mako > /tmp/SM00.xml
diff --ignore-all-space snapshots/SuperMario_00_Build_And_Run_Unit_Tests/config.xml /tmp/SM00.xml

jjj -v 'name=SuperMario_10_Upload_Debian_Package' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_10_Upload_Debian_Package/config.xml.mako > /tmp/SM10.xml
diff --ignore-all-space snapshots/SuperMario_10_Upload_Debian_Package/config.xml /tmp/SM10.xml

jjj -v 'name=SuperMario_20_Deploy_To_Testing' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_20_Deploy_To_Testing/config.xml.mako > /tmp/SM20.xml
diff --ignore-all-space snapshots/SuperMario_20_Deploy_To_Testing/config.xml /tmp/SM20.xml

jjj -v 'name=SuperMario_30_System_Test_In_Testing' -c etc/supermario/supermario.json templates/supermario/jobs/SuperMario_30_System_Test_In_Testing/config.xml.mako > /tmp/SM30.xml
diff --ignore-all-space snapshots/SuperMario_30_System_Test_In_Testing/config.xml /tmp/SM30.xml

