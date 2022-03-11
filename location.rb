require 'net/http'
require 'net/https'

def make_abstract_request
    uri = URI('https://ipgeolocation.abstractapi.com/v1/?api_key=6054a93a680f43de9c81ee0ecb697652')

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request =  Net::HTTP::Get.new(uri)

    response = http.request(request)
    puts "Status code: #{ response.code }"
    puts "Response body: #{ response.body }"
rescue StandardError => error
    puts "Error (#{ error.message })"
end

make_abstract_request()
