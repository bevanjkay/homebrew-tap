cask "bmd-converters" do
  require "net/http"

  version "9.0.0,d3ae9836178a4498ac5608a4fe512b4d,42bccac89a5741c2bd8ee306aab0d4d6"
  sha256 "6a7e725f637de733a9224242ad2854715e3c994d86aebc43a17912e4fbb23df9"

  url do
    params = {
      "platform"     => "Mac OS X",
      "downloadOnly" => "true",
      "country"      => "us",
      "policy"       => "true",
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Blackmagic Converters"
  desc "Utility to update and control Blackmagic Design Converters"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"converters\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Converters_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Converters #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil: [
    "com.blackmagic-design.Converters",
    "com.blackmagic-design.ConvertersAssets",
    "com.blackmagic-design.ConvertersUninstaller",
    "com.blackmagic-design.IPVideo2",
    "com.blackmagic-design.MicConverter",
    "com.blackmagic-design.MicroConverters",
  ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Converters Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.converters.utility.savedState",
  ]
end
