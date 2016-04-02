# bootstrap and configure zsh
class people::bgerstle::shell {
  package {
    'zsh': ;
  }

  # See def in hiera
  include nodejs::global

  boxen::env_script { 'local_node_bin_on_path':
    content => 'export PATH=node_modules/.bin:$PATH'
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
