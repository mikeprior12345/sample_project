require 'net/http'
require 'net/https'
require 'json'
class EmailType
def self.emailchk(email)
    #uri = URI('http://time.jsontest.com')
    uri = URI("https://emailvalidation.abstractapi.com/v1/?ENV[“ABSTRACT_EMAIL_API”]&email=#{email}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request =  Net::HTTP::Get.new(uri)
    response = http.request(request)
    puts "Status code: #{ response.code }"
    puts "Response body: #{ response.body }"
json = JSON.parse(response.body)
#is_free_email
ans=json.detect {|k,v| k=="is_free_email" }
#ans=json.extract!("time").values
#p ans
if ans.to_s.include? "TRUE"
   puts "Free email account"
   result = 'Free email'
else
 puts "Business email account"
 result = 'Business email'
end
rescue StandardError => error
    puts "Error (#{ error.message })"
end
end
