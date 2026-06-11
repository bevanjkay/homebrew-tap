cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.41"
  sha256 arm:          "a6606afdc13062d5b1a595faac410c399f3231fa65db57f3b27e0434eed48509",
         intel:        "ff70b55aeca94e277bfd5a6f9e717274db0852d906f8c8a272e87a520e08d63b",
         x86_64_linux: "aaf20ad0e871178afb38e0dee1e6deb893d7e5557900104b71c03d836ab732ad",
         arm64_linux:  "b0ab800b8815b2bb08f2282685458a870cfa60e638f745cdf74df3e4d64a7e59"

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
