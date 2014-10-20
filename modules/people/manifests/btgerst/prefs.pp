class people::btgerst::prefs {
  require stdlib

  # define a resource which will ensure & install a plist preference file
  # and then (optionally) restart the app
  define app_preferences(
    $prefs_domain = undef,
    $killall = undef) {
    $abs_filepath = "${boxen::config::srcdir}/dotrcfiles/${title}"
    file { $abs_filepath:
      ensure => present,
      require => Repository["${boxen::config::srcdir}/dotrcfiles"]
    }

    $install_cmd = "defaults import ${prefs_domain} ${title}"
    exec { $install_cmd:
      cwd         => "${boxen::config::srcdir}/dotrcfiles",
      subscribe   => File["${abs_filepath}"],
      require     => Repository["${boxen::config::srcdir}/dotrcfiles"],
      refreshonly => true
    }
    if type($killall) == 'string' and size($killall) > 1 {
      exec { "killall ${killall}":
        refreshonly => true,
        notify      => Exec[$install_cmd]
      }
    }
  }

  app_preferences { 'iTerm2Prefs.plist':
    prefs_domain => 'com.googlecode.iterm2'
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