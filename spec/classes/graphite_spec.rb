require 'spec_helper'

describe 'graphite' do

  context 'RedHat supported platforms' do
    ['6.5','7.5'].each do | operatingsystemrelease |
      let(:facts) {{ :osfamily => 'RedHat', :operatingsystemrelease => operatingsystemrelease}}
      describe "defaults" do
        it { should contain_anchor('graphite::begin') }
        it { should contain_class('graphite::install') }
        it { should contain_class('graphite::config') }
        it { should contain_anchor('graphite::end') }
      end
    end
  end

  context 'RedHat unsupported platforms' do
    ['5.0'].each do | operatingsystemrelease |
      let(:facts) {{ :osfamily => 'RedHat', :operatingsystemrelease => operatingsystemrelease}}
      describe "Redhat #{operatingsystemrelease} fails" do
        it { expect { should contain_class('graphite')}.to raise_error(Puppet::Error, /Unsupported RedHat release/) }
      end
    end
  end

  context 'Debian supported platforms' do
    ['trusty','squeeze'].each do | lsbdistcodename |
      let(:facts) {{ :osfamily => 'Debian', :lsbdistcodename => lsbdistcodename}}
      describe "defaults" do
        it { should contain_anchor('graphite::begin') }
        it { should contain_class('graphite::install') }
        it { should contain_class('graphite::config') }
        it { should contain_anchor('graphite::end') }
      end
    end
  end

  context 'Debian unsupported platforms' do
    ['capybara'].each do | lsbdistcodename |
      let(:facts) {{ :osfamily => 'Debian', :lsbdistcodename => lsbdistcodename}}
      describe "Debian #{lsbdistcodename} fails" do
        it { expect { should contain_class('graphite')}.to raise_error(Puppet::Error, /Unsupported Debian release/) }
      end
    end
  end

end