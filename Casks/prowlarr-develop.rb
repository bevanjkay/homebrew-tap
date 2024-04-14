cask "prowlarr-develop" do
  arch arm: "arm64", intel: "x64"

  version "1.16.1.4420,develop"
  sha256 arm:   "c8ecc4cfca3a270db3b77da8e8445813f79ee129d72cb7881b1d352465398c8d",
         intel: "4598069514a5f184554ec2fc439888da6d1362dbb8a4987443e8232e77d9ab5a"

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
