cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.107"
  sha256 arm:          "df6370051325bae7c22ace9a378b0bf4c128a54a6c3b817c7d80f57a109adac1",
         intel:        "0c906dcabad7aec9162a62bdd06c014411f091a6dfd26e42ad57596d13222937",
         arm64_linux:  "4e0ce0a54e85c7e71dd1b0708fc1e80acd8c3c8a1f73c68327d547111914bae7",
         x86_64_linux: "74f7c8fb44f2964ed0ea1423f3554dc03bfae279acf4393711579b8cf783923c"

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
