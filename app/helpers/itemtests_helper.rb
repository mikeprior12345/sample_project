require 'net/http'
require 'net/https'
require 'json'
require 'active_support'
module ItemtestsHelper
    def index_item_count
        emailtype = User.find_by(id: current_user.id).emailtype
        user_email = User.find_by(id: current_user.id).email
        user = User.find(current_user.id)
        numitems = user.itemtests.count
        if @itemtests.where(:user_id  => current_user.id).first
            "#{user_email} (#{emailtype}) has #{numitems} items"
        else
           "#{user_email} (#{emailtype}) has no items" 
        end
    end
def index_show_country_city
    apikey = ENV['ABSTRACT_GEO_API'].to_s
    uri = URI("https://ipgeolocation.abstractapi.com/v1/?api_key=#{apikey}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request =  Net::HTTP::Get.new(uri)
    response = http.request(request)
    puts "Status code: #{ response.code }"
    puts "Response body: #{ response.body }"
json = JSON.parse(response.body)
country = json.extract!("country").values.to_s.gsub(/[\"\[\]]/, '') 
city = json.extract!("city").values.to_s.gsub(/[\"\[\]]/, '')
"Country: #{country} City: #{city}"
 end
end
