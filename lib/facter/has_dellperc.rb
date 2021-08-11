# frozen_string_literal: true

# Fact:
#   has_dellperc
#
# Purpose:
#   Return true if a Dell PERC (LSI MegaRAID) controller is installed
#
# Resolution:
#   On physical hosts with the lspci binary, parse the output for known MegaRAID
#   strings.
#
Facter.add('has_dellperc') do
  confine kernel: :linux
  confine is_virtual: false

  setcode do
    haslspci = Facter::Util::Resolution.exec('which lspci')
    if haslspci.nil?
      # no lspci on this system
    else
      output = Facter::Util::Resolution.exec("#{haslspci} -v")
      if %r{Dell PERC}i.match?(output)
        true
      else
        false
      end
    end
  end
end
