class people::btgerst::apps {
  include macvim
  include iterm2::stable

  class { 'intellij':
    edition => 'community',
  }
}
