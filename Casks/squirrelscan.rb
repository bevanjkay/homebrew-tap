cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.73"
  sha256 arm:          "6847f40ea763defd93e850ec393e1a3d64616b339bcd3509c7fb740ea1d9e012",
         intel:        "751e5d7dc493872858d4f0dad17f0c5bb04952404d84c9b937174cd59dbed92d",
         x86_64_linux: "fb2c4bc75a876117679c6990221a492e29bdc76973134b422a08d8a30f5a2cbc",
         arm64_linux:  "5b88c3cb369df35e7b039a81ccc92e8989af584f43c737313ddcf54c126b2e43"

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
