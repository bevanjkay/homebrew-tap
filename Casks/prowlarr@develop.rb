cask "prowlarr@develop" do
  arch arm: "arm64", intel: "x64"

  version "1.17.1.4483,develop"
  sha256 arm:   "4bf2e07d3648ff90a22d6d6310d0f88fa555f66f3bf44ea304e9b8e610e8441a",
         intel: "0eb2cb77eab4587e2979f9a5825c1108c2b0994c61ba2e01ba6dcb988e4e20ea"

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
