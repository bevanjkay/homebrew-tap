cask "rpcs3" do
  version "0.0.29-15590-6bc7d7c6,6bc7d7c69851bda16949b82c9159dc75d6c25b76"
  sha256 "3430d91b3c7c7e76b6f679ebddbcbe20d012a413d46eba8870c9b699b9ed6307"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.second}/rpcs3-v#{version.csv.first}_macos.dmg",
      verified: "github.com/RPCS3/rpcs3-binaries-mac/"
  name "RPCS3"
  desc "PS3 emulator"
  homepage "https://rpcs3.net/"

  livecheck do
    url "https://rpcs3.net/download"
    regex(%r{href=.*?([^-]+)/rpcs3[._-]v?((?:\d+(?:[.-]\d+)+)[._-](?:[a-f]|[0-9])+)[._-]macos\.dmg}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match.second},#{match.first}" }
    end
  end

  app "RPCS3.app"
end
