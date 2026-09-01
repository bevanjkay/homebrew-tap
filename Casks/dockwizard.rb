cask "dockwizard" do
  version "0.2.0"
  sha256 "b8710af5e945b8f4589a77ed6fd8d55a01ac19b5370ccc60671b7f583b11c959"

  url "https://github.com/bevanjkay/dockwizard/releases/download/v#{version}/DockWizard-#{version}.dmg"
  name "DockWizard"
  desc "Dock manager with portable presets and a command-line tool"
  homepage "https://github.com/bevanjkay/dockwizard"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: :tahoe

  app "DockWizard.app"
  binary "#{appdir}/DockWizard.app/Contents/Helpers/dockwizard"

  zap trash: [
    "~/Library/Application Support/DockWizard",
    "~/Library/Preferences/me.bevankay.dockwizard.plist",
    "~/Library/Saved Application State/me.bevankay.dockwizard.savedState",
  ]
end
