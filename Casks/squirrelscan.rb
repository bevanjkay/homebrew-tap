cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.58"
  sha256 arm:          "70501edc3a3c279bf4370e2a1c62da4fc22dceaa1ee6d7a706ad8e2af305fefb",
         intel:        "20b70d565934ed91a0147bb5cd7c0c6b33c4454312f36e61faf7225b84b3961b",
         x86_64_linux: "e1fa02c8f3e1993dfa33f6a6cb1d170930f58025e38af5bd0617d3e09857704e",
         arm64_linux:  "6989b9a9973e35bb749d7ab92b71ce1bff218a4152f56b0c3749576fc85dd325"

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
