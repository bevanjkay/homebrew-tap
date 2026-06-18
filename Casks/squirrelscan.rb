cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.53"
  sha256 arm:          "1384da50600433cd43f67c5016dc17ca09a17c21db7acaebb1bdb3920cee3a90",
         intel:        "6a6b9d10b09c38eeaea2b48d54d144a951a1226b1950680a7564540e665630c0",
         x86_64_linux: "e190931af926e5414f6b042bb7982ab5288c396d826816197be9d522d323d551",
         arm64_linux:  "adb4db53ddc83db171519c95a3672cee6a47af10944a87bf3318c0d7f4daa9a7"

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
