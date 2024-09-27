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
    params = @params.to_json

    response = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })
    download_url = response.body

    # Download from the resolved URL
    curl_download download_url, to: temporary_path
  end
end
