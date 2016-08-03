# Personal manifest for Java setup
class people::bgerstle::java {
  package { 'gradle': ; }
  package { [
    'java',
    'android-studio'
  ]:
    provider => 'brewcask'
  }

  boxen::env_script { 'JAVA_HOME':
    content => "export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home\n"
  }
}

