# My python setup
class people::btgerst::python {
  require stdlib
  include ::python

  define py_version {
    ::python::version { $title: }
    ::python::package { "virtualenv for ${title}":
        package => 'virtualenv',
        python  => $title,
    }
  }

  py_version { ['2.7.6', '3.4.1']: }

  # Installing a pyenv plugin
  python::plugin { 'pyenv-virtualenvwrapper':
    ensure => 'v20140609',
    source => 'yyuu/pyenv-virtualenvwrapper',
  }

  boxen::env_script { 'pyenv-virtualenvwrapper':
    content => 'pyenv virtualenvwrapper'
  }
}
