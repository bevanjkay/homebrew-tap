# frozen_string_literal: true

require "json"
require "net/http"
# require "cask/download_strategy"

class BmdDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **options)
    super
    @params = options[:data]
  end

  def _fetch(url:, resolved_url:, timeout:)
    # Custom logic for POST request to get the actual download URL
    uri = URI(url)
    @params.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # Only disable SSL for this request

    request = Net::HTTP::Post.new(uri, { "Content-Type" => "application/json" })
    request.body = @params.to_json

    response = http.request(request)
    download_url = JSON.parse(response.body)["download_url"]

    # Download from the resolved URL
    curl_download download_url, to: temporary_path
  end
end
