cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.49"
  sha256 arm:          "3393315f8580a64bccdb4373aefcc3fc401620774ae42f64a48aaad4fdfb7f38",
         intel:        "5371eb1ea51c9ffe1c9eb430b0ae13227b7de1515f1f3c726dd5c2d374ef154f",
         x86_64_linux: "f4671479b1dd19ef035b55642f4822ae841abc81d54a252375050672f82f0de0",
         arm64_linux:  "65ec7d9570d88b9c53483fc6d425b712e7ac1febf069f145040a55c5fdca16db"

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
