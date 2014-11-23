require 'spec_helper'
describe 'eximsmarthost' do

  context 'with defaults for all parameters' do
    it { should contain_class('eximsmarthost') }
  end
end
