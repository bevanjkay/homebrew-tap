cask "rpcs3" do
  version "0.0.40-18941-fecb53f8,fecb53f86c55fde6e260617f6b1289cabf1687bf"
  sha256 "a69c490180e8125d81164bac5667e355e0b977a4310340e1a2a0f763d9cb46af"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.second}/rpcs3-v#{version.csv.first}_macos.7z",
      verified: "github.com/RPCS3/rpcs3-binaries-mac/"
  name "RPCS3"
  desc "PS3 emulator"
  homepage "https://rpcs3.net/"

  livecheck do
    url "https://update.rpcs3.net/?api=v3&os_type=macos&os_arch=x64&os_version=999"
    regex(%r{/build[._-]([^-]+)/rpcs3[._-]v?((?:\d+(?:[.-]\d+)+)[._-](?:[a-f]|[0-9])+)[._-]macos\.7z}i)
    strategy :json do |json, regex|
      json.dig("latest_build", "mac", "download").scan(regex).map { |match| "#{match[1]},#{match[0]}" }
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
