cask "rpcs3" do
  version "0.0.34-17503-e72cb680,e72cb6801a4e083360f20700116f80a780185a1a"
  sha256 "b21273abac40aaba8059bc37040afc024d93000576cc89794b2ad77815b9557b"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.second}/rpcs3-v#{version.csv.first}_macos.7z",
      verified: "github.com/RPCS3/rpcs3-binaries-mac/"
  name "RPCS3"
  desc "PS3 emulator"
  homepage "https://rpcs3.net/"

  livecheck do
    url "https://rpcs3.net/download"
    regex(%r{href=.*?([^-]+)/rpcs3[._-]v?((?:\d+(?:[.-]\d+)+)[._-](?:[a-f]|[0-9])+)[._-]macos\.7z}i)
    strategy :page_match do |page, regex|
      current_version, current_build = version.csv
      build, version = page.scan(regex).max_by(&:first)

      current_build_number = current_version.split("-").second
      build_number = version.split("-").second

      # If the current version is within 5 builds of the latest, use the current version
      if build_number && current_build_number.to_i + 5 > build_number.to_i
        version = current_version
        build = current_build
      end

      "#{version},#{build}"
    end
  end

  depends_on macos: ">= :monterey"

  app "RPCS3.app"

  zap trash: [
    "~/Library/Application Support/rpcs3",
    "~/Library/Caches/rpcs3",
  ]

  caveats do
    requires_rosetta
  end
end
