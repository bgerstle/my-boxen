class people::bgerstle::apps {
  include macvim
  include iterm2::stable

  package { 'Intellij-IDEA-IC-14.0.3':
    ensure   => 'present',
    provider => 'appdmg_eula',
    source   => 'http://download.jetbrains.com/idea/ideaIC-14.0.3-jdk-bundled.dmg'
  }
}
