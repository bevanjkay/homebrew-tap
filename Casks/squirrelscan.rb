cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.190"
  sha256 arm:          "fca4545cc96a37ce45a6d2efc823cdf21879594d8f19238143885a2fa943a1d8",
         intel:        "64d48c35cf0e18bcc49b5d7d793288190b0fd655de35b1f34848060da9f1128d",
         arm64_linux:  "44b2d0c8213798ec28cd029a957af6bcda95e3e9810414c2850477dc9ab6ef37",
         x86_64_linux: "b5f8435409083728cbb4fc91762b5bc3afbc7451502160b3daf723bc63e87772"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
    throttle days: 3
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
