cask "rpcs3" do
  version "0.0.29-15597-ff4485d8,ff4485d8ae6515105dfb6e1ff9c38e326372b5ec"
  sha256 "3185802809947d8803a85798806e84b16ee65f4f16994fb8c614ab31e5cd9c45"

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
