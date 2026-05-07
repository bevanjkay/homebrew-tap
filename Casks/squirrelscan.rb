cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.38"
  sha256 arm:          "b5ac9895d3bf084e224f7e675818e799d3f01567218a774cc45cd4a6523866a8",
         intel:        "ae328d5d92a1b431aea6474ff1ddcc2b2bb63bc64ca7467d5b57afe655902606",
         x86_64_linux: "ca906c279933263b4ad61c599c7ac935e4fe36f7d41ee37eb5b51378319d1cbb",
         arm64_linux:  "bbfbfdb4e16ad44311ed0d9964afa55d3cb76f4494ebead4df6a3057b7beec39"

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
