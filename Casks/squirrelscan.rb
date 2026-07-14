cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.72"
  sha256 arm:          "8a18c23eceabc22d9d1ce7f7befe3618884058e6e5ef066ab2a86126840144ac",
         intel:        "e628a87bee986c6a3baf9c5b16f6643ae0780d891683d725f6995a0ac20964c2",
         x86_64_linux: "771f2db2447022a30bc49a200fba88e994dd302b0b627e9418e7b8176b3968da",
         arm64_linux:  "e46bb69195539496dbfe857a13e32d8a173535d4ccfabc7183642665b4884123"

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
