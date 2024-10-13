require 'jwt_helper/version'
require 'base64'
require 'json'
require 'openssl'

module JwtHelper
  class Jwt
    def self.validate(jwt, secret)
      encoded_header, encoded_payload, encoded_signature = jwt.split('.')

      exp_sig = OpenSSL::HMAC.digest('SHA256', JWT_SECRET_KEY, "#{encoded_header}.#{encoded_payload}")
      exp_encoded_sig = Base64.urlsafe_encode64(exp_sig, padding: false)

      # Check if the signature with the newly created is match
      if exp_encoded_sig != encoded_signature
        return {'error': "invalid signature"} 
      end

      decoded_header = Base64.urlsafe_decode64(encoded_header)
      decoded_payload = Base64.urlsafe_decode64(encoded_payload)

      header = JSON.parse(decoded_header)
      payload = JSON.parse(decoded_payload)

      unless header.key?("account")
        return {'error': 'account is not present'}
      end

      if header['account'] != JWT_ACCOUNT
        return {'error': 'invalid account'}
      end

      unless header.key?("exp")
        return {'error': "key expired is not present"} 
      end

      if header['exp'] < Time.now.to_i
        return {'error': 'token is expired'}
      end

      {data: payload}
    end

    def self.generate(payload, ttl)
      unix_now = Time.now.to_i
      header = {
        alg: 'HS256',
        typ: 'JWT',
        account: JWT_ACCOUNT,
        iat: unix_now,
        exp: unix_now + ttl.to_i
      }

      encoded_header = Base64.urlsafe_encode64(header.to_json, padding: false)
      encoded_payload = Base64.urlsafe_encode64(payload.to_json, padding: false)

      signature = OpenSSL::HMAC.digest('SHA256', JWT_SECRET_KEY, "#{encoded_header}.#{encoded_payload}")
      encoded_signature = Base64.urlsafe_encode64(signature, padding: false)

      "#{encoded_header}.#{encoded_payload}.#{encoded_signature}"
    end

  end
end
