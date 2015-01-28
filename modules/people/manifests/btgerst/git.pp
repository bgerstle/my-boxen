# my global git settings
class people::btgerst::git {
  git::config::global {
    'user.name':
      value => 'Brian Gerstle';
    'push.default':
      value => 'tracking';
    'branch.autosetuprebase':
      value => 'always';
    'color.ui':
      value => 'auto';
    'rerere.enabled':
      value => '1';
    'apply.whitespace':
      value => 'fix';
  }
}
