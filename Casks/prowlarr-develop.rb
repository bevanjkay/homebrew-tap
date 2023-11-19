cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.10.4.4088,develop"
  sha256 arm:   "a012d96cdbe88ca14fe9dc98d634fbb71cd9b46e3889902d2dac6a4ef86a11b5",
         intel: "7681c990360181a5d0975b5e5d7c51b6cef4d6e8126c0c6d5c53c383b1f99280"

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
