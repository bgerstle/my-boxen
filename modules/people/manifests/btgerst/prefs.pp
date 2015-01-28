class people::btgerst::prefs {
  require stdlib

  # define a resource which will ensure & install a plist preference file
  # and then (optionally) restart the app
  define app_preferences(
    $prefs_domain = undef,
    $killall = undef) {
    $abs_filepath = "${boxen::config::srcdir}/dotfiles/${title}"
    file { $abs_filepath:
      ensure => present,
      require => Repository["${boxen::config::srcdir}/dotfiles"]
    }

    $install_cmd = "defaults import ${prefs_domain} ${title}"
    exec { $install_cmd:
      cwd         => "${boxen::config::srcdir}/dotfiles",
      subscribe   => File["${abs_filepath}"],
      require     => Repository["${boxen::config::srcdir}/dotfiles"],
      refreshonly => true
    }
    if type($killall) == 'string' and size($killall) > 1 {
      exec { "killall ${killall}":
        refreshonly => true,
        notify      => Exec[$install_cmd]
      }
    }
  }

  app_preferences { 'FinderPrefs.plist':
    prefs_domain  => 'com.apple.finder',
    killall       => 'Finder'
  }
  app_preferences { 'DockPrefs.plist':
    prefs_domain  => 'com.apple.dock',
    killall       => '-HUP Dock'
  }
}