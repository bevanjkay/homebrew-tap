cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.45"
  sha256 arm:          "29f63bacddf7718fa8f46e9f1c5fd33cffaa0f6e77abaab52b3c1ac9ef6438c5",
         intel:        "8088c2d0d398f4ed59aa1fb0591255e38197631ae210f93f7c7ad84fb38a45c0",
         x86_64_linux: "2886dbb1b573dd67b8176a267ece4269b51853c62dcf6da927bbdb4c7c690b90",
         arm64_linux:  "d1160286678fefe7a49e33f246e480c12792da120af9711a43030cd1d38c5b74"

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
