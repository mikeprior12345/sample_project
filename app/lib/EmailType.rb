require 'net/http'
require 'net/https'
require 'json'
class EmailType
def self.emailchk(email)
    apikey = ENV['ABSTRACT_EMAIL_API'].to_s
    uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=#{apikey}&email=#{email}")
        http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_PEER
                     request =  Net::HTTP::Get.new(uri)
                            response = http.request(request)
                            puts "Status code: #{ response.code }"
                            puts "Response body: #{ response.body }"
                            json = JSON.parse(response.body)
                            checkfree = json.detect {|k,v| k=="is_free_email" }
                            if checkfree.to_s.include? "TRUE"
                               puts "Free email account"                                                    
                                  result = 'Free email'
                            elsif checkfree.to_s.include? "FALSE"
                                   puts "Business email account"
                                    result = 'Business email'
                                else
                                    puts "Unknown email account"
                                    result = 'Unknown email account'
                                    end
                                    rescue StandardError => error
                                        puts "Error (#{ error.message })"
                                        end
                                        end

