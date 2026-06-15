cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.48"
  sha256 arm:          "4e61692bba6b8ad9ff353b583c8edbc2a3e2ec8493fe0cc5fc5c51340dd5623d",
         intel:        "f35d89c3737a8831b6b80d71ac9b272572286282777bd1415efbadb139cbe3ae",
         x86_64_linux: "c3f8870f434ce8d3aee7273be41773567a7679dcafda5cd1442d725a81e67d5e",
         arm64_linux:  "74556e4f46cda38585caea57f0e2df47937c7fd2ab88875a23196b85f0f89576"

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
