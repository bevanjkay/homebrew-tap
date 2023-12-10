cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.11.0.4128,develop"
  sha256 arm:   "db386d2849c5a02c4130ddeccdbf4e7649495d0c8ab70269f27b1eef918c044c",
         intel: "e3b1f383e468bcc9d5c9285e11ba68eb7cf40c1f3403c8075c9a0e0cb5867ccc"

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
