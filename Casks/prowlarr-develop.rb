cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.8.5.3896"
  sha256 arm:   "ee90bdb06b17ace2156a294b8f958bc0fda644b1671d8db52c62721d15d6a632",
         intel: "4de95a50ab1e7531c1f7ff447d82f5a71360dad12944436e10d606f96b83708c"

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
