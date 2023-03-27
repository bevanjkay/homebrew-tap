cask "bmd-atem" do
  require "net/http"

  version "9.0.1,31147502ea3b44c9b6c749fa77d97ded,6765474e9cdc4cfe9a152cbd2efcf39d"
  sha256 "d277449354890ff455b244a45654d911d22b7099d590ff4eb8bc9cc460c302c5"

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
  name "Blackmagic ATEM"
  desc "Update and manage Blackmagic ATEM Switchers"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"atem\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  container nested: "Blackmagic_ATEM_Switchers_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install ATEM #{version.csv.first.chomp(".0")}.pkg"

  uninstall script: {
    executable: "/Applications/Blackmagic ATEM Switchers/Uninstall ATEM.app/Contents/Resources/uninstall.sh",
    sudo: true
  },
  pkgutil: [
    "com.blackmagic-design.Switchers",
    "com.blackmagic-design.SwitchersAssets",
    "com.blackmagic-design.SwitchersUninstaller",
  ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.ATEM Setup.plist",
    "~/Library/Preferences/com.blackmagic-design.ATEM Software Control.plist",
    "~/Library/Saved Application State/com.blackmagic-design.switchers.softwarecontrol.savedState",
  ]
end
