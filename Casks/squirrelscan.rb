cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.66"
  sha256 arm:          "878918aa4b7657027736217bcb2147d600ad01c36114de30397c13624d50a22b",
         intel:        "0d20380782a9ce040ea86910ec42ff4cf943b090192e3f41ec664c9f33ad3fa9",
         x86_64_linux: "7610d09e93f284c0939a496b91b631c3e42269fcbf779a7af2a269f947471585",
         arm64_linux:  "3350e1c2cab0e435ad0f6080bca5b302d6431f6b897e1d1668ecc0bac80243ed"

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
