cask "fusion-studio@beta" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "21.0.4,c3610040628c45c6b59cf2d1d6e9a4ec,e1ab5bd95b4b429ea195ecc2c49dcd88,"
  sha256 "d1dffd0e4cc6ed4d03791cf3764d86453e31c6259cc4bb520f0ba15fc2e264ab"

  url "https://www.blackmagicdesign.com/api/register/au/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "product"      => {
          "name" => "Fusion Studio",
        },
        "policy"       => "true",
        "downloadOnly" => "true",
        "country"      => "au",
      }
  name "Fusion Studio"
  desc "Visual effects software"
  homepage "https://www.blackmagicdesign.com/au/products/fusion/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "fusion-studio"
      end
      matched.map do |download|
        beta = /beta/i.match?(download["name"])
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]},#{"b" if beta}"
      end&.first
    end
  end

  auto_updates true
  conflicts_with cask: "fusion-studio"
  depends_on :macos

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
