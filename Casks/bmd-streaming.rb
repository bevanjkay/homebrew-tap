cask "bmd-streaming" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "4.1.1,9f209d8f9ea34c838efb003e3d075980,198dfbfbe91b459b93e48afea8dbaa5e"
  sha256 "6a1615365a3440c6ddf75d7d947a368c969e8d5d120d8d6d559346c7ad5b238e"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Streaming"
  desc "Update and manage Blackmagic Streaming Encoder Hardware"
  homepage "https://www.blackmagicdesign.com/products/blackmagicstreamingprocessors"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "web-presenter"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Streaming #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Streaming/Uninstall Streaming.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.WebPresenter",
              "com.blackmagic-design.WebPresenterAssets",
              "com.blackmagic-design.WebPresenterUninstaller",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Streaming Setup.plist"
end
