cask "rpcs3" do
  version "0.0.40-18947-951d47c9,951d47c94c1428a40f1f676129a3ab901bd41860"
  sha256 "2e7cb002a82ac12bd5ea68aed57bbf18d315b9446d83a277e86c675194860157"

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
