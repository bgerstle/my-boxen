# Module to setup haskell on my machine
class people::bgerstle::haskell {
  # TODO: download dmg/pkg of HaskellPlatform
  boxen::env_script { 'cabal':
    content => "export PATH=/Users/${::boxen_user}/Library/Haskell/bin:\$PATH"
  }
}
