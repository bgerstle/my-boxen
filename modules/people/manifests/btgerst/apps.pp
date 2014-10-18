class people::btgerst::apps {
  include macvim
  include iterm2::stable
  include intellij # parameters set in btgerst.yaml
  include adium
  include harvest
  include xctool
  include flux
  include spotify
  include tower
  include onepassword
  include hipchat
  include caffeine
  include dropbox
  include chrome
  include atom
  include screenhero

  # Homebrew packages
  package { 'tig': }
}
