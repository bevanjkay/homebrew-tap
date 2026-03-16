cask "rpcs3" do
  version "0.0.40-18970-297db871,297db8713fbb02bfb156edb6c03c68850825a83e"
  sha256 "032acb7ed798ea740ece01aff79cb4167cfec58e5fdb2805a87252652dc43338"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.second}/rpcs3-v#{version.csv.first}_macos.7z",
      verified: "github.com/RPCS3/rpcs3-binaries-mac/"
  name "RPCS3"
  desc "PS3 emulator"
  homepage "https://rpcs3.net/"

  disable! date: "2026-03-16", because: "uses too many CI minutes"

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
