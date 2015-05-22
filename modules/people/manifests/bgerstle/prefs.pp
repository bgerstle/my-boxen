# OSX System & App preferences
class people::bgerstle::prefs {
  require stdlib
  require people::bgerstle::dotfiles

  # OSX settings
  include osx::global::key_repeat_rate
  include osx::global::key_repeat_delay
  include osx::global::disable_key_press_and_hold
  include osx::finder::show_hidden_files

  # Individual app preferences
  # TODO: move into dotfiles?
  define app_preferences(
    $prefs_domain = undef,
    $killall = undef) {
    validate_string($killall)
    $abs_filepath = "${boxen::config::srcdir}/dotfiles/${title}"
    file { $abs_filepath:
      ensure  => present,
      require => Repository["${boxen::config::srcdir}/dotfiles"]
    }
    $install_cmd = "defaults import ${prefs_domain} ${title}"
    exec { $install_cmd:
      cwd         => "${boxen::config::srcdir}/dotfiles",
      subscribe   => File[$abs_filepath],
      require     => Repository["${boxen::config::srcdir}/dotfiles"],
      refreshonly => true
    }
    $exec_title = "killall ${killall}"
    if !defined(Exec[$exec_title]) {
      ensure_resource('exec', $exec_title, {
        refreshonly => true,
        notify      => Exec[$install_cmd]
      })
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
