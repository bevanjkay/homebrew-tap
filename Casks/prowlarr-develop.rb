cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.9.3.4013"
  sha256 arm:   "c538290d4f48b220dd47b06d69bd198be47b065c0bf0764e11740992f9a78922",
         intel: "48f834122a39d3fac4bf64c094a79eb57037db26eaf8e77e47c22283482d5b4c"

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
