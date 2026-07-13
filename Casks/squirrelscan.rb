cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.70"
  sha256 arm:          "2d938220144687389b54072801f1ea37d4abb2af00006f6d6440d7f05e6e6275",
         intel:        "2fb147a753c0c51ce5336e772ab73ff792c2b844f21dee69292e57a2ac175131",
         x86_64_linux: "47f49dc96ffc8e27349f92abd39eb2552ae40a9fc6baaf40db16424c739803c7",
         arm64_linux:  "4fb77db4563fb546d845c4106b1e5dbc32f239f7feef7c6361fef0df89472e2b"

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
