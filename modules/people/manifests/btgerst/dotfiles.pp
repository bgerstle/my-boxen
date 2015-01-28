# Stuff related to cloning & setting up my dotfiles
class people::btgerst::dotfiles {
  # Add my dotfiles repo
  repository { "${boxen::config::srcdir}/dotfiles":
    source => 'btgerst/dotfiles'
  }

  # Link certain dotfiles to the HOME dir
  $linked_dot_files = ['.vim',
                        '.vimrc',
                        '.zshrc',
                        '.gitignore_global',
                        '.xvimrc']

  # Define resource which will create a link to the file's title in the
  # user's home dir
  define dot_file {
    file { "/Users/${::boxen_user}/${title}":
      ensure  => link,
      target  => "${boxen::config::srcdir}/dotfiles/${title}",
      require => Repository["${boxen::config::srcdir}/dotfiles"]
    }
  }

  # Declare the list of dotfiles to be linked
  dot_file { $linked_dot_files: }
}
