<?xml version='1.0' encoding='UTF-8'?>
<hudson>
  <disabledAdministrativeMonitors/>
  <version>1.547</version>
  <numExecutors>2</numExecutors>
  <mode>NORMAL</mode>
  <useSecurity>true</useSecurity>
  <authorizationStrategy class="hudson.security.GlobalMatrixAuthorizationStrategy">
    <permission>com.cloudbees.plugins.credentials.CredentialsProvider.View:jenkins</permission>
    <permission>hudson.model.Computer.Configure:jenkins</permission>
    <permission>hudson.model.Computer.Configure:spotifyusers</permission>
    <permission>hudson.model.Computer.Connect:jenkins</permission>
    <permission>hudson.model.Computer.Connect:spotifyusers</permission>
    <permission>hudson.model.Computer.Create:jenkins</permission>
    <permission>hudson.model.Computer.Create:spotifyusers</permission>
    <permission>hudson.model.Computer.Delete:jenkins</permission>
    <permission>hudson.model.Computer.Delete:spotifyusers</permission>
    <permission>hudson.model.Computer.Disconnect:jenkins</permission>
    <permission>hudson.model.Computer.Disconnect:spotifyusers</permission>
    <permission>hudson.model.Hudson.Administer:spotifyusers</permission>
    <permission>hudson.model.Hudson.ConfigureUpdateCenter:jenkins</permission>
    <permission>hudson.model.Hudson.ConfigureUpdateCenter:spotifyusers</permission>
    <permission>hudson.model.Hudson.Read:anonymous</permission>
    <permission>hudson.model.Hudson.Read:jenkins</permission>
    <permission>hudson.model.Hudson.Read:spotifyusers</permission>
    <permission>hudson.model.Hudson.RunScripts:jenkins</permission>
    <permission>hudson.model.Hudson.RunScripts:spotifyusers</permission>
    <permission>hudson.model.Hudson.UploadPlugins:jenkins</permission>
    <permission>hudson.model.Hudson.UploadPlugins:spotifyusers</permission>
    <permission>hudson.model.Item.Build:spotifyusers</permission>
    <permission>hudson.model.Item.Cancel:jenkins</permission>
    <permission>hudson.model.Item.Cancel:spotifyusers</permission>
    <permission>hudson.model.Item.Configure:spotifyusers</permission>
    <permission>hudson.model.Item.Create:spotifyusers</permission>
    <permission>hudson.model.Item.Delete:spotifyusers</permission>
    <permission>hudson.model.Item.Discover:spotifyusers</permission>
    <permission>hudson.model.Item.Read:anonymous</permission>
    <permission>hudson.model.Item.Read:jenkins</permission>
    <permission>hudson.model.Item.Read:spotifyusers</permission>
    <permission>hudson.model.Item.Workspace:spotifyusers</permission>
    <permission>hudson.model.Run.Delete:spotifyusers</permission>
    <permission>hudson.model.Run.Update:jenkins</permission>
    <permission>hudson.model.Run.Update:spotifyusers</permission>
    <permission>hudson.model.View.Configure:spotifyusers</permission>
    <permission>hudson.model.View.Create:spotifyusers</permission>
    <permission>hudson.model.View.Delete:spotifyusers</permission>
    <permission>hudson.model.View.Read:spotifyusers</permission>
    <permission>hudson.scm.SCM.Tag:jenkins</permission>
    <permission>hudson.scm.SCM.Tag:spotifyusers</permission>
  </authorizationStrategy>
  <securityRealm class="hudson.security.LDAPSecurityRealm" plugin="ldap@1.6">
    <server>ldap://haldap.spotify.net</server>
    <rootDN>dc=carmen,dc=int,dc=sto,dc=spotify,dc=net</rootDN>
    <inhibitInferRootDN>false</inhibitInferRootDN>
    <userSearchBase>cn=users</userSearchBase>
    <userSearch>uid={0}</userSearch>
    <groupSearchBase>cn=groups</groupSearchBase>
    <managerDN>uid=teamcity,cn=users,dc=carmen,dc=int,dc=sto,dc=spotify,dc=net</managerDN>
    <managerPassword>YmZZeVdXRFpjazZqak01bUdtQzE=</managerPassword>
    <disableMailAddressResolver>false</disableMailAddressResolver>
  </securityRealm>
  <disableRememberMe>false</disableRememberMe>
  <projectNamingStrategy class="jenkins.model.ProjectNamingStrategy$DefaultProjectNamingStrategy"/>
  <workspaceDir><%text>${ITEM_ROOTDIR}/workspace</%text></workspaceDir>
  <buildsDir><%text>${ITEM_ROOTDIR}/builds</%text></buildsDir>
  <jdks/>
  <viewsTabBar class="hudson.views.DefaultViewsTabBar"/>
  <myViewsTabBar class="hudson.views.DefaultMyViewsTabBar"/>
  <clouds/>
  <slaves>
    % for slave in config["slaves"]:
    <slave>
      <name>${slave["name"]}</name>
      <description>${slave["description"]}</description>
      <remoteFS>/spotify/jenkins-agent/.</remoteFS>
      <numExecutors>2</numExecutors>
      <mode>NORMAL</mode>
      <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
      <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves@1.5">
        <host>${slave["host"]}</host>
        <port>22</port>
        <credentialsId>de6872c0-c902-4d51-abfb-e3ee3f5574d0</credentialsId>
      </launcher>
      <label>${slave["label"]}</label>
      <nodeProperties/>
      <userId>jjj</userId>
    </slave>
    % endfor
  </slaves>
  <quietPeriod>5</quietPeriod>
  <scmCheckoutRetryCount>0</scmCheckoutRetryCount>
  <views>
    <hudson.model.AllView>
      <owner class="hudson" reference="../../.."/>
      <name>All</name>
      <filterExecutors>false</filterExecutors>
      <filterQueue>false</filterQueue>
      <properties class="hudson.model.View$PropertyList"/>
    </hudson.model.AllView>
    <au.com.centrumsystems.hudson.plugin.buildpipeline.BuildPipelineView plugin="build-pipeline-plugin@1.4.2">
      <owner class="hudson" reference="../../.."/>
      <name>${config["build pipeline"]["name"]}</name>
      <filterExecutors>false</filterExecutors>
      <filterQueue>false</filterQueue>
      <properties class="hudson.model.View$PropertyList"/>
      <gridBuilder class="au.com.centrumsystems.hudson.plugin.buildpipeline.DownstreamProjectGridBuilder">
        <firstJob>${config["build pipeline"]["first job"]}</firstJob>
      </gridBuilder>
      <noOfDisplayedBuilds>${config["build pipeline"]["number of builds"]}</noOfDisplayedBuilds>
      <buildViewTitle></buildViewTitle>
      <consoleOutputLinkStyle>Lightbox</consoleOutputLinkStyle>
      <cssUrl></cssUrl>
      <triggerOnlyLatestJob>false</triggerOnlyLatestJob>
      <alwaysAllowManualTrigger>false</alwaysAllowManualTrigger>
      <showPipelineParameters>false</showPipelineParameters>
      <showPipelineParametersInHeaders>false</showPipelineParametersInHeaders>
      <refreshFrequency>3</refreshFrequency>
      <showPipelineDefinitionHeader>false</showPipelineDefinitionHeader>
    </au.com.centrumsystems.hudson.plugin.buildpipeline.BuildPipelineView>
  </views>
  <primaryView>All</primaryView>
  <slaveAgentPort>50072</slaveAgentPort>
  <label></label>
  <nodeProperties/>
  <globalNodeProperties/>
</hudson>
