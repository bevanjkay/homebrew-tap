cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.60"
  sha256 arm:          "a3c4fed28b42934f3208f8ea41a7ddfb1e76a03e77cd8741489ebf7ae212c3b3",
         intel:        "2a161a72c7b74df3a246ee1645dc01646a1157ae3acdb059a47debade302e0f8",
         x86_64_linux: "385cb37097c780799fc4b82fd926c68509c1e7bb7b6695ec33ec694980e0171e",
         arm64_linux:  "e5f2bd9b6d0d6ccd43b4ee47976a162dc4421e8077e3d43e7b649d7ded320fd0"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}",
      verified: "github.com/squirrelscan/squirrelscan/"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/squirrel-#{version}-darwin-#{arch}" if OS.mac?
  end

  zap trash: "~/.squirrel"
end
