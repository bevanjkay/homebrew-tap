cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.59"
  sha256 arm:          "d2489d2a9560fa82d588b49185f2282e55ae67b92e251c72ebef8140c855c0ae",
         intel:        "c126695cdff3dcf74b0c57c5bed82031a067a2d8625909bf36e850c6bd2dc9f0",
         x86_64_linux: "7dc0e21bf0152ec3d01261e0a72be54d55c4d0289d34c048c316f0fe6fe07bef",
         arm64_linux:  "d56ca1fa38d3c44007af2780831f67785fc472bc6f2f987c25f84cfe1896a874"

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
