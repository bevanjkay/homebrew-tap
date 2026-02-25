cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"

  version "0.0.38"
  sha256 arm:   "b5ac9895d3bf084e224f7e675818e799d3f01567218a774cc45cd4a6523866a8",
         intel: "asdf"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-darwin-#{arch}",
      verified: "github.com/squirrelscan/squirrelscan/"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-darwin-#{arch}/i)
  end

  binary "squirrel-#{version}-darwin-#{arch}", target: "squirrel"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/squirrel-#{version}-darwin-#{arch}"
  end

  zap trash: "~/.squirrel"
end
