<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@2.0">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>${config["git repository"]}</url>
        <credentialsId>de6872c0-c902-4d51-abfb-e3ee3f5574d0</credentialsId>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/master</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions>
      % if config["jobs"][name]["checkout directory"]:
      <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
        <relativeTargetDir>${config["jobs"][name]["checkout directory"]}</relativeTargetDir>
      </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
      % endif
    </extensions>
  </scm>
  <assignedNode>${config["jobs"][name]["node"]}</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    % if config["jobs"][name]["poll scm"]:
    <hudson.triggers.SCMTrigger>
      <spec>${config["jobs"][name]["poll scm"]}</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
    % endif
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>

    % for task in config["jobs"][name]["tasks"]:
    % if task["type"] == "shell":
    <hudson.tasks.Shell>
      <command><%include file="/${task['commands']}" /></command>
    </hudson.tasks.Shell>
    % elif task["type"] == "copy artifact":
    <hudson.plugins.copyartifact.CopyArtifact plugin="copyartifact@1.28">
      <project>${task["source"]}</project>
      <filter>build/**</filter>
      <target></target>
      <selector class="hudson.plugins.copyartifact.TriggeredBuildSelector">
        <fallbackToLastSuccessful>true</fallbackToLastSuccessful>
      </selector>
    </hudson.plugins.copyartifact.CopyArtifact>
    % endif
    % endfor

  </builders>
  <publishers>
    % if config["jobs"][name]["archive artifacts"]:
    <hudson.tasks.ArtifactArchiver>
      <artifacts>${config["jobs"][name]["archive artifacts"]}</artifacts>
      <latestOnly>false</latestOnly>
      <allowEmptyArchive>false</allowEmptyArchive>
    </hudson.tasks.ArtifactArchiver>
    % endif
    % if config["jobs"][name]["check for failures"]:
    <hudson.plugins.postbuildtask.PostbuildTask plugin="postbuild-task@1.8">
      <tasks>
        <hudson.plugins.postbuildtask.TaskProperties>
          <logTexts>
            <hudson.plugins.postbuildtask.LogProperties>
              <logText>##teamcity\[testFailed .*\]</logText>
              <operator>AND</operator>
            </hudson.plugins.postbuildtask.LogProperties>
          </logTexts>
          <EscalateStatus>true</EscalateStatus>
          <RunIfJobSuccessful>true</RunIfJobSuccessful>
          <script># Force an error, any other better and cleaner way to do it?&#xd;
false&#xd;
</script>
        </hudson.plugins.postbuildtask.TaskProperties>
      </tasks>
    </hudson.plugins.postbuildtask.PostbuildTask>
    % endif
    <hudson.tasks.Mailer plugin="mailer@1.6">
      <recipients>${config["jobs"][name]["mail recipients"]}</recipients>
      <dontNotifyEveryUnstableBuild>true</dontNotifyEveryUnstableBuild>
      <sendToIndividuals>true</sendToIndividuals>
    </hudson.tasks.Mailer>
    % if config["jobs"][name]["trigger"]:
    <hudson.tasks.BuildTrigger>
      <childProjects>${config["jobs"][name]["trigger"]}</childProjects>
      <threshold>
        <name>SUCCESS</name>
        <ordinal>0</ordinal>
        <color>BLUE</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </hudson.tasks.BuildTrigger>
    % endif
  </publishers>
  <buildWrappers>
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.5.7"/>
    <hudson.plugins.ansicolor.AnsiColorBuildWrapper plugin="ansicolor@0.3.1">
      <colorMapName>xterm</colorMapName>
    </hudson.plugins.ansicolor.AnsiColorBuildWrapper>
  </buildWrappers>
</project>
