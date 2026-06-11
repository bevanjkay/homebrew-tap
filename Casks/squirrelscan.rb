cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.42"
  sha256 arm:          "cab474f10c16d7e3c7bcfd6a347290f551e45e054cd2429ca26ec023a0f0e643",
         intel:        "dd5478ef7c925d9d3eb338e149d6b459ad32567dbc3b0b8d00690c764a3db2b2",
         x86_64_linux: "31574c2b9915acbbcc6389072a384fc01a4f6bf13deb93d12de84b8a56d98737",
         arm64_linux:  "19fbfbf955641fcdefcd21106d854d4eb06d38ccb05495c3c2007ace749bf772"

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
