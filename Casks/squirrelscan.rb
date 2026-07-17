cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.75"
  sha256 arm:          "4059cb3d003c2887c7f7d9a40394d8803b86a09540dbb1f268b0e0469e008675",
         intel:        "137911f56dbfd156101f14676b1b3fc3e716cf8666ffd1d622cbc8434057feee",
         x86_64_linux: "41b78922257b0b00bbf5a3c2cabfbe51c62b4559b55300c83a273348d73a350e",
         arm64_linux:  "6f0bf3a2c0bd17aba18b2ef5003c0676971f118820236e0627428f71f27003db"

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
