cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.81"
  sha256 arm:          "7ad8de45f3cc3c794a89e40a03b6f72c449692a26d0c3a1f2057858e6dafd48d",
         intel:        "738a1bc042bb7059141defdfe10b5edab0923dcb0329647e5ec8dfeb7d30403f",
         x86_64_linux: "0d8e1aacac256050f197d08eaa68aa5aa18129f82d60270ee75b2add4c2a83d6",
         arm64_linux:  "72ded2e99385dbd7c171eb51153c1c3b0516636822abe285da68548ad0a73460"

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
