cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.96"
  sha256 arm:          "d7e72b68c40141bab5efbf541bf7533c72a6909421b33cbaf7548b593b0f51e1",
         intel:        "c103d8ed28bce11b01f1cad939afe54d1a493b1ddb018d7b09fc1c399a2de836",
         arm64_linux:  "69350e8e107da629cd606ee1fc0df12fe94c2ea040504f8f61c922d94a850ed9",
         x86_64_linux: "b2d0e6c37c63f188d7f97eb286ab7774c4181e2efacea988daed481fdb11dc91"

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
