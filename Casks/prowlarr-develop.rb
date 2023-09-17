cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.9.0.3966"
  sha256 arm:   "a613e084b01386dbe5f75fccad6d5baceb415c015e32b0f525735063eeeab9a0",
         intel: "02b1fcb52abc4bc4a972d33372e0bc0e38c4ddcce89e12e5c4e9e3adff1cfff1"

  url "https://github.com/Prowlarr/Prowlarr/releases/download/v#{version}/Prowlarr.develop.#{version}.osx-app-core-#{arch}.zip",
      verified: "github.com/Prowlarr/Prowlarr/"
  name "Prowlarr"
  desc "Indexer manager/proxy for various PVR apps"
  homepage "https://prowlarr.com/"

  livecheck do
    url "https://prowlarr.servarr.com/v1/update/develop/changes?os=osx"
    strategy :json do |json|
      json.first["version"]
    end
  end

  conflicts_with cask: "prowlarr"
  depends_on macos: ">= :high_sierra"

  app "Prowlarr.app"

  zap trash: "~/.config/Prowlarr"
end
