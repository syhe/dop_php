require_relative '../../../kitchen/data/spec_helper'

describe file('/etc/php5/mods-available/xdebug.ini') do
  it { should be_file }
end

describe file('/etc/php5/fpm/conf.d/20-xdebug.ini') do
  it { should be_symlink }
end

describe file('/etc/php5/cli/conf.d/20-xdebug.ini') do
  it { should be_symlink }
end
