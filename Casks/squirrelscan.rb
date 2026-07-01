cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.61"
  sha256 arm:          "717afe496eed4e193a214775a1ac91cded5ef517fea5b456f6c0c11d554d7f81",
         intel:        "9cabb4e2abd297b58ae230989392dc39a9e6e6cf2d4aad554e5171a8eb35e86c",
         x86_64_linux: "9dc46ce8ab7ba2feb182222daaf3b4d4929e7595ab30d0608a8303bc16cadb4f",
         arm64_linux:  "c4061a6d4d42d4a55d40f66988b12faaad2bc75c1215cfaa3670f0577595e888"

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
