require 'spec_helper_acceptance'

describe 'eximsimple class' do
  describe 'running puppet code' do
    it 'apply manifest' do
      pp = <<-EOS
        class { 'eximsimple': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

  describe package('exim') do
    it { should be_installed }
  end

  describe service('exim') do
    it { should be_running }
    it { should be_enabled }
  end

  describe file('/etc/exim/exim.conf') do
    it { should be_file }
  end

  describe file('/etc/aliases') do
    it { should be_file }
  end

  describe port(25) do
    it do
      # When provisioning a box, it takes a while for Exim to start listening.
      # Dirty hack: sleep and hope it comes up in time.
      unless ENV['BEAKER_provision'] == 'no'
        sleep(30)
      end
      should be_listening
    end
  end
end
