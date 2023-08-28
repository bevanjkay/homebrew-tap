cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.8.4.3884"
  sha256 arm:   "d1258f5b7f0c7f34cfcb1f77adef3ae12514db7a84f5817efd5365d0db5120b8",
         intel: "622d8d27bc593cdb47ac7d61e35b5ed781b4500d1e52ff81253488df083b5198"

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
