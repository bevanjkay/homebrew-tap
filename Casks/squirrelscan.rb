cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.57"
  sha256 arm:          "43b4b5544a7b1fac0053974d542a150ec7eacdbafcd94ce268d2dfaff9b1d5e8",
         intel:        "417ab7c3fc8ffcf98c7cee5855f786cf9417b4d88963672a0f20fb3b3bf4459e",
         x86_64_linux: "45314968e65d1e0ba9bf190122380768f00e65a12d44e1349128efcd1815138c",
         arm64_linux:  "711c83f506d3412bd7e1b39179a524404f4848738ef8f1c3ae098bd8bcde05c6"

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
