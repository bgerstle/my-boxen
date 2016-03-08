# Packages I want globally installed
class people::bgerstle::tools {
  include vagrant
  include brewcask

  class { 'virtualbox':
    version     => '5.0.14',
    patch_level => '105127'
  }

  # Homebrew packages
  package {
    'tig': ;
    'ffmpeg': ;
    'imagemagick': ;
    'chisel': ;
  }

  file { '.lldbinit':
    path    => "/Users/${::boxen_user}/.lldbinit",
    content => template('people/bgerstle/.lldbinit.erb'),
    require => Package['chisel']
  }

  # FIXME: screengif can't install because it can't find imagemagick?

  # launchd.conf is no longer supported in yosemite
  # TODO: setup using LaunchAgents plist: http://apple.stackexchange.com/a/106814
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
