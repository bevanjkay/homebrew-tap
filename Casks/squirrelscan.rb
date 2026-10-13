cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.111"
  sha256 arm:          "1ab64766d71ed9891d7d5a1055b0c8fbe0e686c8044494286b661e222b075708",
         intel:        "adb220aa3e3e050c911446249ae605c21b644b737191e158f97e98f6f033009b",
         arm64_linux:  "a7f334045ef9afb3aa53debdd06d9916af8e02e2c7d76a9844b63e9bd5e9bd2e",
         x86_64_linux: "fe5109b6ec714cfdc84190ec407948d98563d5997d0466d6d129170083dca399"

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
