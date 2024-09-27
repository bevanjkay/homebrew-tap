cask "bmd-web-presenter" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "3.5.0,e7235bb733f84fab92836049c8a4f7c5,16f9c7e0debe4464af9ba076588bc5ad"
  sha256 "36d8c4824cd49e2a9a0d4544751f98c8afb17faf863884e1c55c7744ca168fe0"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Web Presenter"
  desc "Update and manage Blackmagic Web Presenter Hardware"
  homepage "https://www.blackmagicdesign.com/products/blackmagicwebpresenter"

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

  pkg "Install Web Presenter #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Web Presenter/Uninstall Web Presenter.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.WebPresenter",
              "com.blackmagic-design.WebPresenterAssets",
              "com.blackmagic-design.WebPresenterUninstaller",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Web Presenter Setup.plist"
end
