# My python setup
class people::btgerst::python {
  require stdlib
  include ::python
  include ::python::global

  # Installing a pyenv plugin
  python::plugin { 'pyenv-virtualenvwrapper':
    ensure => 'v20140609',
    source => 'yyuu/pyenv-virtualenvwrapper',
  }

  boxen::env_script { 'pyenv-virtualenvwrapper':
    source => 'puppet:///modules/people/btgerst/pyenv-virtualenvwrapper.sh'
  }
}
