cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.67"
  sha256 arm:          "25f9f1048c1cb1a72e0bb72f23202bc8c180415e232c0d56e8309ec9e2b03a9b",
         intel:        "3deb16ddde7ea1f34eee0f5d08415964d4dd0fbb866f1ba802eb8e81e129ad64",
         x86_64_linux: "f12281342ca3c382f391e957c93ebf833ed209f044b6547154c976a7012583bc",
         arm64_linux:  "7997e53f450075d473a891478c0b4d4e2a1c7f6ff0e859330f6b6ef7a7bcf7ea"

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
