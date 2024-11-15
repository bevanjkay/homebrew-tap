cask "rpcs3" do
  version "0.0.34-17110-d78c39b3,d78c39b3abaeb6cf697b0fe893445ed08882cc7e"
  sha256 "8ae67465f3fc0a8596e2f7fd771117dbb6b413a8c2f17b04d509b21c2d1a2399"

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
