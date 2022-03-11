require "openssl"
require "base64"
require "active_support/core_ext/array/extract_options"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/message_verifier"
require "active_support/messages/metadata"
require 'net/http'
require 'net/https'
require 'json'
require 'active_support'
cookie = "57667eb887dde048a99c8834a00ce200"
cookie = URI.decode_www_form_component(cookie)
data, iv, auth_tag = cookie.split("--").map do |v| 
  Base64.strict_decode64(v)
end
cipher = OpenSSL::Cipher.new("aes-256-gcm")

# Compute the encryption key
 secret_key_base = Rails.application.secret_key_base
 secret = OpenSSL::PKCS5.pbkdf2_hmac_sha1(secret_key_base, "authenticated encrypted cookie", 1000, cipher.key_len)
#
# # Setup cipher for decryption and add inputs
 cipher.decrypt
 cipher.key = secret
 cipher.iv  = iv
 cipher.auth_tag = auth_tag
 cipher.auth_data = ""

 # Perform decryption
 cookie_payload = cipher.update(data)
 cookie_payload << cipher.final
 cookie_payload = JSON.parse cookie_payload
# => {"_rails"=>{"message"=>"InRva2VuIg==", "exp"=>nil, "pur"=>"cookie.remember_token"}}
#
# # Decode Base64 encoded stored data
 decoded_stored_value = Base64.decode64 cookie_payload["_rails"]["message"]
 stored_value = JSON.parse decoded_stored_value
