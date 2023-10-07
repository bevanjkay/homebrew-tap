cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.9.2.3992"
  sha256 arm:   "9d87c56966f9cd84389216ca3ec07933bb7d49c2883bebbe3a79c5be10daf92a",
         intel: "22b4f3574a4c8f1cf51cde6f0c681f68b22662094141ed6ae7b6b8a8d9f28139"

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
