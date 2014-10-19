class people::btgerst {
  notify { 'class people::btgerst declared': }

  $my_home = "/Users/${::boxen_user}"

  include homebrew
  include people::btgerst::apps
  include people::btgerst::dotfiles
  include people::btgerst::prefs
  include zsh
  include java

  $oh_my_zsh_srcdir = "${boxen::config::srcdir}/oh-my-zsh"
  repository { "${oh_my_zsh_srcdir}":
    source => 'robbyrussell/oh-my-zsh',
  }
  file { "${my_home}/.oh-my-zsh":
    ensure  => link,
    target  => $oh_my_zsh_srcdir,
    require => Repository[$oh_my_zsh_srcdir]
  }

  # Export shell vars to native apps using launchctl
  exec { "${boxen::config::repodir}/script/export_env_to_launchctl":
    environment => [
      "BOXEN_ENV_DIR=${boxen::config::envdir}"
    ]
  }
}
