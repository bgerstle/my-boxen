class people::btgerst::tools {
  require stdlib
  include people::btgerst::python
  include java

  # Homebrew packages
  package {
    'maven': ;
    'leiningen': ;
    'tig': ;
    'zsh': ;
  }

  package { 'Java for OSX':
    ensure   => installed,
    provider => pkgdmg,
    source   => 'http://support.apple.com/downloads/DL1572/en_US/JavaForOSX2014-001.dmg'
  }

  boxen::env_script { 'JAVA_HOME':
    content => "export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_${java::update_version}.jdk/Contents/Home"
  }

  $oh_my_zsh_srcdir = "${boxen::config::srcdir}/oh-my-zsh"
  repository { $oh_my_zsh_srcdir:
    source => 'robbyrussell/oh-my-zsh',
  }
  file { "${my_home}/.oh-my-zsh":
    ensure  => link,
    target  => $oh_my_zsh_srcdir,
    require => Repository[$oh_my_zsh_srcdir]
  }


  # launchd.conf is no longer supported in yosemite
#  $env_vars_to_export = ['PATH',
#                         'JAVA_HOME',
#                         'M2_HOME',
#                         'RUBY_HOME',
#                         'PYENV_HOME',
#                         'NODENV_ROOT',
#                         'BUNDLE_BIN_PATH',
#                         'GEM_HOME']
#
#  $joined_env_vars = join($env_vars_to_export, ' ')
#
#  # Export shell vars to native apps using launchctl
#  exec { "${boxen::config::repodir}/script/export_env_to_launchctl ${joined_env_vars}":
#    environment => [
#      "BOXEN_ENV_DIR=${boxen::config::envdir}"
#    ]
#  }
}
