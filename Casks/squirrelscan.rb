cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.44"
  sha256 arm:          "ce8edc8ccb0b76375ada5f701b642c7d3e12ff6b670bedddb9d3ca5d8f0b9d67",
         intel:        "a16367f4d854ea6ddc399b0bdeb06e1f0b13d986cc638601b451e33c107f351b",
         x86_64_linux: "0b7ded17d013f0b253b89e99b01f58307042b356d5d8aaadfee2779664926430",
         arm64_linux:  "710973faca440f96091f17a3d5771ac507778a4a2e1df7aedbd40858f47b4449"

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
