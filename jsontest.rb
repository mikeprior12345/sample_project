require 'net/http'
require 'net/https'
require 'json'
require 'active_support'
module Geoapi
def self.showlocation
    uri = URI('http://time.jsontest.com')
    #uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=ab1d164dc59243378d784e1efdeb6645&email=#{email}")
    http = Net::HTTP.new(uri.host, uri.port)
    #http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request =  Net::HTTP::Get.new(uri)
    response = http.request(request)
    puts "Status code: #{ response.code }"
    puts "Response body: #{ response.body }"
json = JSON.parse(response.body)
#is_free_email
#ans=json.detect {|k,v| k=="date" }
country = json.extract!("time").values
city = json.extract!("date").values
puts "Country: #{country} City #{city}"
return country,city
#if ans.to_s.include? "TRUE"
#   puts "Free email account"
#   result = 'Free email'
#else
# puts "Business email account"
# result = 'Business email'
#end
rescue StandardError => error
    puts "Error (#{ error.message })"
return json
p json
end
 end
Geoapi.showlocation
