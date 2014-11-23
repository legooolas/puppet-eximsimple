require 'spec_helper'

describe 'eximsmarthost' do
  it {
    should contain_package('exim').with({
      'ensure' => 'present',
    })
  }
  it {
    should contain_service('exim').with({
      'ensure' => 'running',
    })
  }
end
