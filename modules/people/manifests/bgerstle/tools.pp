# Packages I want globally installed
class people::bgerstle::tools {
  include vagrant
  include brewcask

  # Homebrew packages
  package {
    'maven': ;
    'gradle': ;
    'leiningen': ;
    'tig': ;
    'oclint':
      provider => 'brewcask'
      ;
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
