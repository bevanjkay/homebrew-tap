cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.54"
  sha256 arm:          "e0fd4e9b06de01e5c3e66768231f7eac54bd65dc454ff4c16126525eeceffbb0",
         intel:        "287a9d180bb6d86771e3cd73110c2a7fae2178dcb962568c6eeb61a3f86b0211",
         x86_64_linux: "28f46ed678435698ed33cecce0bd4fd6ce61ccd61c93f05f629a9664f8561edd",
         arm64_linux:  "6bd004de829b7a089efab8ff5c5f0f3f427cd97e61df28fac42b2dc938b65132"

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
