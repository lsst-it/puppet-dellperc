# frozen_string_literal: true

require 'spec_helper'

describe 'has_dellperc', type: :fact do
  subject(:fact) { Facter.fact(:has_dellperc) }

  before(:each) { Facter.clear }

  context 'when on linux' do
    context 'when on physical hardware' do
      context 'when lspci not in path' do
        it do
          allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
          allow(Facter.fact(:is_virtual)).to receive(:value).and_return(false)
          allow(Facter::Util::Resolution).to receive(:exec).with('which lspci').and_return(nil)

          expect(fact.value).to be_nil
        end
      end

      context 'when lspci output does not match' do
        it do
          allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
          allow(Facter.fact(:is_virtual)).to receive(:value).and_return(false)
          allow(Facter::Util::Resolution).to receive(:exec).with('which lspci').and_return('/usr/sbin/lspci')
          allow(Facter::Util::Resolution).to receive(:exec).with('/usr/sbin/lspci -v') do
            File.read(fixtures('facts', 'lspci_no_match'))
          end

          expect(fact.value).to be false
        end
      end

      context 'when lspci output does match' do
        it do
          allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
          allow(Facter.fact(:is_virtual)).to receive(:value).and_return(false)
          allow(Facter::Util::Resolution).to receive(:exec).with('which lspci').and_return('/usr/sbin/lspci')
          allow(Facter::Util::Resolution).to receive(:exec).with('/usr/sbin/lspci -v') do
            File.read(fixtures('facts', 'lspci_match'))
          end

          expect(fact.value).to be true
        end
      end
    end

    context 'when on virtual hardware' do
      it do
        allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
        allow(Facter.fact(:is_virtual)).to receive(:value).and_return(true)

        expect(fact.value).to be_nil
      end
    end
  end # on linux

  context 'when not on linux' do
    it do
      allow(Facter.fact(:kernel)).to receive(:value).and_return('Solaris')
      allow(Facter.fact(:is_virtual)).to receive(:value).and_return(false)

      expect(fact.value).to be_nil
    end
  end # not on linux
end
