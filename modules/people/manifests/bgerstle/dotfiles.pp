# Stuff related to cloning & setting up my dotfiles
class people::bgerstle::dotfiles {
  $dotfiles_dir = "${::boxen::config::srcdir}/dotfiles"

  $all_dotfiles = ['.vim',
                  '.vimrc',
                  '.zshrc',
                  '.gitignore_global',
                  '.xvimrc',
                  '.bundle/config']

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
  # TODO: make ctags

  file { '.lldbinit':
    path    => "/Users/${::boxen_user}/.lldbinit",
    content => template('people/bgerstle/.lldbinit.erb'),
    require => Package['chisel']
  }

  # TODO: install source code pro font
}
