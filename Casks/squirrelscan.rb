cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.77"
  sha256 arm:          "0acf972cbeb3047bbde6fa30c931af4fa2f7e7ef850459988e3ef745876b75b8",
         intel:        "15bd144580f5a388a890ffe761ceb41467f801ca9705b15ac35367b8bbda4b01",
         x86_64_linux: "e72a515e0f0ebccc0d8576e3c31fece3e0f993a86a9f09e0f635c290a0d53643",
         arm64_linux:  "7c07c9f78c55be63b9bd22fc97c1cc582ef266b90754b66b66a0faa802cb94ab"

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
