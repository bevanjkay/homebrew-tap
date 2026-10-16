cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.116"
  sha256 arm:          "8af2f76dd8b0c3ebe448982c4c7059fead90849e86aa2f2170380ac67450ee36",
         intel:        "f62f49742bd94efcaac77439d9afae3bde0b3b8d07dfacaabce4276444eb34fc",
         arm64_linux:  "0ce93f2d277990c396b4fe31ecea28f88f85ca8bda9b75622a20016da3b11d2d",
         x86_64_linux: "f8fd88e6149ca64d556e02cdaf348992e9bc13817b478475583b301797fa3ec6"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr",
          args:         ["-d", "com.apple.quarantine", "{{staged_path}}/squirrel-{{version}}-darwin-{{arch}}"],
          must_succeed: false
    end
  end

  zap trash: "~/.squirrel"
end
