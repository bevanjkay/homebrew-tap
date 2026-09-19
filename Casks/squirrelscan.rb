cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.97"
  sha256 arm:          "548a3c01cd6e110b5fd581e3cff9b2b1ee80f6d91f50a10739898ae17d962399",
         intel:        "b83022920e8b38c866ab51e7ec92c16a275c09f1549ee49c54998adb45d655b2",
         arm64_linux:  "821ee90a189b4e406a452ea043b92cf533fd0b67fc44552f6f40c152f879e496",
         x86_64_linux: "38b651ee0482d67e6db497e375e2148cc609297baf1be1cef0cf1ea1663019c2"

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
