# Stuff related to cloning & setting up my dotfiles
class people::btgerst::dotfiles {
  # Add my dotrcfiles repo
  repository { "${boxen::config::srcdir}/dotrcfiles":
    source => 'btgerst/dotrcfiles'
  }

  # Link certain dotfiles to the HOME dir
  $linked_dotrc_files = ['.vim',
                        '.vimrc',
                        '.zshrc',
                        '.gitignore_global',
                        '.xvimrc']

  # Define resource which will create a link to the file's title in the
  # user's home dir
  define dotrc_file {
    file { "/Users/${::boxen_user}/${title}":
      ensure  => link,
      target  => "${boxen::config::srcdir}/dotrcfiles/${title}",
      require => Repository["${boxen::config::srcdir}/dotrcfiles"]
    }
  }

  # Declare the list of dotfiles to be linked
  dotrc_file { $linked_dotrc_files: }
}
