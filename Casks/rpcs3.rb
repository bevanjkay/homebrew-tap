cask "rpcs3" do
  version "0.0.40-18950-16277576,16277576089e1733987deeac54b627b25d67d800"
  sha256 "6f9b461b8ca6e889eb3a2aa2b649587f5933c6aa51ac3b1bd309daa3c3e1296b"

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
