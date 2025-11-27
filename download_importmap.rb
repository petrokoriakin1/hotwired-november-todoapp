#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'uri'
require 'fileutils'

# Disable SSL verification temporarily
OpenSSL::SSL::SSLContext.new.verify_mode = OpenSSL::SSL::VERIFY_NONE if ENV['INSECURE'] == 'true'

importmap_config = File.read('config/importmap.rb')

# URLs to download from importmap-rails CDN
packages = [
  ['turbo.min.js', 'https://cdn.jsdelivr.net/npm/@hotwired/turbo@7/dist/turbo.es2017-umd.js'],
  ['stimulus.min.js', 'https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3/dist/stimulus.es2017-umd.js'],
  ['stimulus-loading.js', 'https://cdn.jsdelivr.net/npm/@hotwired/stimulus-loading@3/dist/stimulus-loading.es2017-umd.js'],
]

vendor_js_path = 'vendor/javascript'
FileUtils.mkdir_p(vendor_js_path)

packages.each do |filename, url|
  puts "Downloading #{filename}..."
  uri = URI(url)
  
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE # Bypass SSL verification
  
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  
  if response.code == '200'
    File.write(File.join(vendor_js_path, filename), response.body)
    puts "✓ Downloaded #{filename}"
  else
    puts "✗ Failed to download #{filename}: #{response.code}"
  end
end

puts "\nDone!"
