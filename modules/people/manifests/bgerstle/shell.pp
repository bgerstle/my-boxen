# bootstrap and configure zsh
class people::bgerstle::shell {
  package {
    'zsh': ;
  }

  # See def in hiera
  include nodejs::global

  # prefer node executables from local node_modules folder
  boxen::env_script { 'local_node_bin_on_path':
    content  => 'export PATH=node_modules/.bin:$PATH',
    priority => 'highest'
  }

  ruby_gem { 'bundler for all rubies':
    gem          => 'bundler',
    version      => '~> 1.0',
    ruby_version => '*',
  }

  # prefer bundler binstubs if available
  boxen::env_script { 'local_bundle_bin_on_path':
    content  => 'export PATH=.bundle/bin:$PATH',
    priority => 'highest'
  }


  # Installing nodenv plugin
  nodejs::nodenv::plugin { 'nodenv-package-json-engine':
    ensure => 'v1.0.0',
    source => 'nodenv/nodenv-package-json-engine'
  }

  $oh_my_zsh_dir = "/Users/${::boxen_user}/.oh-my-zsh"
  repository { $oh_my_zsh_dir:
    source => 'robbyrussell/oh-my-zsh',
  }

  # set zsh as login shell
  $zsh_executable = "${::boxen::config::homebrewdir}/bin/zsh"
  Package['zsh'] ~> file_line { 'add zsh from brew to /etc/shells':
    path => '/etc/shells',
    line => $zsh_executable
  }

  user { $::boxen_user:
    ensure => present,
    shell  => $zsh_executable
  }
}
