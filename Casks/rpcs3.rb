cask "rpcs3" do
  version "0.0.43-20551-ad468a13,ad468a13f6374f364467a9e4988e95938c37bb42"
  sha256 "80f1cdf6c38e1dd0cd74bb76506b18e77346eb8adf80a29b4c16ee4ddb453286"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.second}/rpcs3-v#{version.csv.first}_macos.7z"
  name "RPCS3"
  desc "PS3 emulator"
  homepage "https://rpcs3.net/"

  livecheck do
    url "https://update.rpcs3.net/?api=v3&os_type=macos&os_arch=x64&os_version=999"
    regex(%r{/build[._-]([^-]+)/rpcs3[._-]v?((?:\d+(?:[.-]\d+)+)[._-](?:[a-f]|[0-9])+)[._-]macos\.7z}i)
    strategy :json do |json, regex|
      json.dig("latest_build", "mac", "download").scan(regex).map { |match| "#{match[1]},#{match[0]}" }
    end
    throttle days: 7
  end

  depends_on macos: :sequoia

  app "RPCS3.app"

  uninstall quit: "net.rpcs3.rpcs3"

  zap trash: [
    "~/Library/Application Support/rpcs3",
    "~/Library/Caches/rpcs3",
  ]

  caveats do
    requires_rosetta
  end
end
