# bootstrap and configure zsh
class people::btgerst::shell {
  package {
    'zsh': ;
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
