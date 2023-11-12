cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.10.2.4064,develop"
  sha256 arm:   "46928c78f765f75d2dcb09c527adaaaeb69e43afa586bea856f424ca945be2b2",
         intel: "2a0a625d0a02ea2a4c25d2263ad06c7d0e60402c7555f95bc0ab60868ff998e9"

  url "https://github.com/Prowlarr/Prowlarr/releases/download/v#{version.csv.first}/Prowlarr.#{version.csv.second}.#{version.csv.first}.osx-app-core-#{arch}.zip",
      verified: "github.com/Prowlarr/Prowlarr/"
  name "Prowlarr"
  desc "Indexer manager/proxy for various PVR apps"
  homepage "https://prowlarr.com/"

  livecheck do
    url "https://prowlarr.servarr.com/v1/update/develop/changes?os=osx"
    strategy :json do |json|
      version = json.first["version"]
      branch = json.first["filename"].match(/Prowlarr\.([^.]+)/i)[1]
      next if version.blank? || branch.blank?

      "#{version},#{branch}"
    end
  end

  conflicts_with cask: "prowlarr"
  depends_on macos: ">= :high_sierra"

  app "Prowlarr.app"

  zap trash: "~/.config/Prowlarr"
end
