# Module to setup haskell on my machine
class people::bgerstle::haskell {
  # TODO: install HaskellForMac?
  # TODO: download dmg/pkg of HaskellPlatform
  # TODO: switch to stack
  boxen::env_script { 'cabal':
    content => "export PATH=/Users/${::boxen_user}/Library/Haskell/bin:\$PATH"
  }
}
