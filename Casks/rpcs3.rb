cask "rpcs3" do
  version "0.0.29-15859-8e911101,8e911101b7b501be1639d346703f2650ebd68d57"
  sha256 "893b8b3b8d86aec2522f21f1ab41d6f24a25048ed004806ba07b4e55a3488764"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.second}/rpcs3-v#{version.csv.first}_macos.7z",
      verified: "github.com/RPCS3/rpcs3-binaries-mac/"
  name "RPCS3"
  desc "PS3 emulator"
  homepage "https://rpcs3.net/"

  livecheck do
    url "https://rpcs3.net/download"
    regex(%r{href=.*?([^-]+)/rpcs3[._-]v?((?:\d+(?:[.-]\d+)+)[._-](?:[a-f]|[0-9])+)[._-]macos\.7z}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match.second},#{match.first}" }
    end
  end

  depends_on macos: ">= :monterey"

  app "RPCS3.app"

  zap trash: [
    "~/Library/Application Support/rpcs3",
    "~/Library/Caches/rpcs3",
  ]
end
