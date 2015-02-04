# Personal manifest for Java setup
class people::btgerst::java {
  include ::java

  package { 'Java for OSX':
    ensure   => installed,
    provider => pkgdmg,
    source   => 'http://support.apple.com/downloads/DL1572/en_US/JavaForOSX2014-001.dmg'
  }

  boxen::env_script { 'JAVA_HOME':
    content => "export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_${::java::update_version}.jdk/Contents/Home\n"
  }
}
