# Custom Metasploit module to ask a BIND DNS server for its version.

require 'msf/core'
require 'net/dns/resolver'

class MetasploitModule < Msf::Auxiliary
  include Msf::Auxiliary::Report
        
  def initialize
    super(
      'Name'           => 'Simple BIND Version Scanner',
      'Version'        => '$Revision: 1 $',
      'Description'    => 'Queries a BIND server for its version',
      'Author'         => 'Student',
      'License'        => MSF_LICENSE
    )

    register_options(
      [
        OptAddress.new('RHOST', [ true, "Specify the target nameserver" ])
      ], self.class)
  end

  def run
    print_status("Running Scan against #{datastore['RHOST']}")
    @res = Net::DNS::Resolver.new()
    @res.nameserver=(datastore['RHOST'])
    query = @res.send("version.bind","TXT","CH")
    if(query)
      query.answer.each do |rr|
        print_good("Reported BIND version = #{rr.txt}")
      end
    end
  end
end
