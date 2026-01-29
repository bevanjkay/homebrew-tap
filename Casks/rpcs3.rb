cask "rpcs3" do
  version "0.0.39-18741-b0b0ed76,b0b0ed7634fa544978a5f2f111905b3a90e68bae"
  sha256 "35438232059c053b2173afbd4dacf58ec799314728cd5d6f1cbb853f4f405b23"

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

  depends_on macos: ">= :sonoma"

  app "RPCS3.app"

  zap trash: [
    "~/Library/Application Support/rpcs3",
    "~/Library/Caches/rpcs3",
  ]

  caveats do
    requires_rosetta
  end
end
