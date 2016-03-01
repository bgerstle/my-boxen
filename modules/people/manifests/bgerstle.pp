# module for Brian Gerstle
class people::bgerstle {
  include people::bgerstle::shell
  include people::bgerstle::apps
  include people::bgerstle::dotfiles
  include people::bgerstle::prefs
  include people::bgerstle::tools
  include people::bgerstle::python
  #include people::bgerstle::java
  include people::bgerstle::haskell
  include people::bgerstle::git

  $oh_my_zsh_srcdir = "${boxen::config::srcdir}/oh-my-zsh"
  repository { $oh_my_zsh_srcdir:
    source => 'robbyrussell/oh-my-zsh',
  }
  file { "${::my_home}/.oh-my-zsh":
    ensure  => link,
    target  => $oh_my_zsh_srcdir,
    require => Repository[$oh_my_zsh_srcdir]
  }

  $env_vars_to_export = ['PATH',
                        'JAVA_HOME',
                        'M2_HOME',
                        'RUBY_HOME',
                        'PYENV_HOME',
                        'NODENV_ROOT',
                        'BUNDLE_BIN_PATH',
                        'GEM_HOME']

  $joined_env_vars = join($env_vars_to_export, ' ')

  # Export shell vars to native apps using launchctl
  exec { "${boxen::config::repodir}/script/export_env_to_launchctl ${joined_env_vars}":
    environment => [
      "BOXEN_ENV_DIR=${boxen::config::envdir}"
    ]
  }
}
