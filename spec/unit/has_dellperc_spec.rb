require 'spec_helper'

describe 'has_dellperc', type: :fact do
  subject(:fact) { Facter.fact(:has_dellperc) }

  before(:each) { Facter.clear }

  context 'on linux' do
    context 'on physical hardware' do
      context 'lspci not in path' do
        it do
          allow(Facter.fact(:kernel)).to receive(:value) { 'Linux' }
          allow(Facter.fact(:is_virtual)).to receive(:value) { false }
          allow(Facter::Util::Resolution).to receive(:exec).with('which lspci') { nil }

          expect(subject.value).to be_nil
        end
      end

      context 'lspci output does not match' do
        it do
          allow(Facter.fact(:kernel)).to receive(:value) { 'Linux' }
          allow(Facter.fact(:is_virtual)).to receive(:value) { false }
          allow(Facter::Util::Resolution).to receive(:exec).with('which lspci') do
            '/usr/sbin/lspci'
          end
          allow(Facter::Util::Resolution).to receive(:exec).with('/usr/sbin/lspci -v') do
            File.read(fixtures('facts', 'lspci_no_match'))
          end

          expect(subject.value).to eq false
        end
      end

      context 'lspci output does match' do
        it do
          allow(Facter.fact(:kernel)).to receive(:value) { 'Linux' }
          allow(Facter.fact(:is_virtual)).to receive(:value) { false }
          allow(Facter::Util::Resolution).to receive(:exec).with('which lspci') do
            '/usr/sbin/lspci'
          end
          allow(Facter::Util::Resolution).to receive(:exec).with('/usr/sbin/lspci -v') do
            File.read(fixtures('facts', 'lspci_match'))
          end

          expect(subject.value).to eq true
        end
      end
    end

    context 'on virtual hardware' do
      it do
        allow(Facter.fact(:kernel)).to receive(:value) { 'Linux' }
        allow(Facter.fact(:is_virtual)).to receive(:value) { true }

        expect(subject.value).to be_nil
      end
    end
  end # on linux

  context 'not on linux' do
    it do
      allow(Facter.fact(:kernel)).to receive(:value) { 'Solaris' }
      allow(Facter.fact(:is_virtual)).to receive(:value) { false }

      expect(subject.value).to be_nil
    end
  end # not on linux
end
