cask "fusion-studio" do
  require "net/http"

  version "18.6.4,ad781aca7e3a447bbdf58970ecd6d2e8,928ad09f6a8c41c2ac35103ab297b4e4,"
  sha256 "c19b7c2bf10f96f579c244f7637602df25f7eee596df3a6c18e072051dc1c67f"

  url do
    params = {
      "platform"     => "Mac OS X",
      "product"      => {
        "name" => "Fusion Studio",
      },
      "policy"       => "true",
      "downloadOnly" => "true",
      "country"      => "au",
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/au/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Fusion Studio"
  desc "Visual effects software"
  homepage "https://www.blackmagicdesign.com/au/products/fusion/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "fusion-studio"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]},#{v["beta"] ? "b" : ""}"
      end
    end
  end

  auto_updates true

  pkg "Install Fusion Studio v#{version.csv.first.chomp(".0")}.pkg"
  pkg "Install Fusion Render Node v#{version.csv.first.chomp(".0")}.pkg"

  # Split uninstall stanza to allow multiple scripts
  uninstall script: {
    executable: "/Applications/Blackmagic Fusion #{version.major}/Uninstall Fusion.app/Contents/Resources/uninstall.sh",
    sudo:       true,
  }
  # Quit render node to enable uninstall
  uninstall quit: "com.blackmagic-design.fusionrendernode"
  uninstall script: {
    executable: "/Applications/Blackmagic Fusion #{version.major} Render Node/Uninstall Fusion Render Node.app/Contents/Resources/uninstall.sh",
    sudo:       true,
  }
  uninstall launchctl: "com.blackmagicdesign.fusion.server",
            pkgutil:   [
              "com.blackmagic-design.Fusion#{version.major}RenderNode",
              "com.blackmagic-design.Fusion#{version.major}RenderNodeAssets",
              "com.blackmagic-design.Fusion#{version.major}RenderNodeUninstaller",
              "com.blackmagic-design.Fusion#{version.major}Studio",
              "com.blackmagic-design.Fusion#{version.major}StudioAssets",
              "com.blackmagic-design.Fusion#{version.major}StudioUninstaller",
            ]

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagicdesign.fusion.server.plist",
    "~/Library/Preferences/com.blackmagic-design.fusion.plist",
    "~/Library/Preferences/com.blackmagic-design.fusionrendernode.plist",
    "~/Library/Saved Application State/com.blackmagic-design.fusion.savedState",
  ]
end
