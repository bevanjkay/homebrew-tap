cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.10.0.4047,develop"
  sha256 arm:   "35c66dd4d9eae0e20e57a810e26d23f99f698bb832b8e2828f578d4b42b1530e",
         intel: "6d84c2098a8b5dbee78c26c9cc5e51ce58a9973f69e5707e340a1026b9658ced"

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
