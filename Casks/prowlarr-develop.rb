cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.9.1.3981"
  sha256 arm:   "a9b98738e85cea087acdeb90fcb805188bb840427a58bc3c70b742e9b30b3588",
         intel: "55f80286b3ac5701bb2b9308e4978274074735def9f2b6afdbab11ab54e5da87"

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
