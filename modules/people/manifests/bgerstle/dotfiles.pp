# Stuff related to cloning & setting up my dotfiles
class people::bgerstle::dotfiles {
  $dotfiles_dir = "${::boxen::config::srcdir}/dotfiles"

  $all_dotfiles = ['.vim',
                  '.vimrc',
                  '.zshrc',
                  '.gitignore_global',
                  '.xvimrc']

  define dot_file {
    file { "/Users/${::boxen_user}/${title}":
      ensure => link,
      target => "${::boxen::config::srcdir}/dotfiles/${title}",
    }
  }

  repository { $dotfiles_dir:
    source => 'bgerstle/dotfiles'
  }
  -> dot_file { $all_dotfiles: }

  package {
    'ctags': ; # needed for easy-tags
  }

  # TODO: install source code pro font
  # TODO: make ctags
}
