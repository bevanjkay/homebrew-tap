cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.69"
  sha256 arm:          "f300004fe136d033f4787e97eed6ecccd27c18b0419b29cd8fab7bba763dcabb",
         intel:        "b818772afa14948e6f2a0c364b12028fd9980506316f054a539e49d3df430665",
         x86_64_linux: "c36d5286b8103dbaea3774d885e4ae6fe78ca1e60c78ce6ea9fe7d6bbc8ec447",
         arm64_linux:  "0bf811d77b18bb8a9a5a10184d1ff48f37aebbc39447eb16411d9274719afe21"

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
