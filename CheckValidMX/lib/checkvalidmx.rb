require 'resolv'
require 'mail'
class CheckValidMX
  def self.mxers(domain)
   mxdomain = Mail::Address.new(domain).domain
    mxs = Resolv::DNS.open do |dns|
      ress = dns.getresources(mxdomain, Resolv::DNS::Resource::IN::MX)
      ress.map { |r| [r.exchange.to_s, IPSocket::getaddress(r.exchange.to_s), r.preference] }
    end
     #check if the mxs object/array has no entries.
     if mxs.empty?
     result = "InvalidEmailDomain"
       else
        result = "ValidEmailDomain"
          end
           return result
   end
end
