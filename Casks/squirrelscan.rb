cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.115"
  sha256 arm:          "fbb991cead31f673ec6a6d3bfc1dfd8bfee29ec123c486b9bcca8bcb40857642",
         intel:        "8a556c232c9e9884645b812e1706ed6d50b1c960c9f922abb7669450cadfab28",
         arm64_linux:  "4f25624bfefb655aaa43dcf40542530d711c033a9e0781341606f17380c15d3c",
         x86_64_linux: "eaf6cca991e63d3f6158e85c9d4586a880574ea0786c8033eb499a52de567936"

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
