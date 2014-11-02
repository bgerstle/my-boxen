class people::btgerst::apps {
  include macvim
  include iterm2::stable
  include harvest
  include xctool
  include flux
  include spotify
  include onepassword
  include caffeine
  include dropbox
  include chrome
  include atom

  class { 'intellij':
    edition => 'community',
  }

  # Homebrew packages
  package {
    'maven': ;
    'leiningen': ;
    'tig': ;
    'ghc': ;
    'ghci': ;
    'cabal-install': ;
  }

  package { 'Java for OSX':
    ensure  => installed,
    provider => pkgdmg,
    source  => 'http://support.apple.com/downloads/DL1572/en_US/JavaForOSX2014-001.dmg'
  }
}
