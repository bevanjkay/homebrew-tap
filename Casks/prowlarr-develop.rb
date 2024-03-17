cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.14.2.4318,develop"
  sha256 arm:   "6119dc6889609069937e7a72e50006f4b3cc8abdc469abf7e105659ea2c873e9",
         intel: "0afd65b1d42dad9a0d945ae4a0769cf8519c8bab92ba59ab4559953ec5eac22a"

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
