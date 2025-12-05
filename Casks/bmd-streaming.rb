cask "bmd-streaming" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "4.2.0,996c92d2641f40d8bb92e5e7f75e8071,1f4066f852394c61a95903146f10f66b"
  sha256 "2ce9ce5d9b3311cd4541c0646f9d4a792eb3e4e28130524d1011f5f5d2a39a02"

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
