cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.87"
  sha256 arm:          "74af21640f3594e15ba9d6a834b14ef50bb6d1c1f5909f8d44c446a66668314f",
         intel:        "8f3222a353750bb1342640ca4ab00122385154ecbe08462562d8185ee73ba821",
         arm64_linux:  "fab079f34549e2f625f4b0181bcad62d38d2d88e44f4c4626ddc112c84a08ee1",
         x86_64_linux: "33e4e9fdc3ac278689bbe30d479e3d3703dd831d253e8ac6c62f1e74d0fe108c"

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
