cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.78"
  sha256 arm:          "f53aec024b2c8f8e2686c6625591d49d12b8eaff557781cb3edc8331c835a145",
         intel:        "8862535fd7e6b014179271abeb3f16d43720378fd629a6728c5b976cd34421dc",
         x86_64_linux: "d09091965525c7dfc75d04ef9e7c03ce4d7696f7017b90d0211262cd85c50889",
         arm64_linux:  "0ce359c44820ca156d762c1028a8817ecd1356433e219ea2f0abf9d8d0174668"

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
