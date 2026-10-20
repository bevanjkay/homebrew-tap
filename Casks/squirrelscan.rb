cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.120"
  sha256 arm:          "b3378e52a1fd22950d53a3aab468f392fe4a323b1d4382388daf15a3c7674f99",
         intel:        "233e99b4e1f7a4a6211af351a49098f819ae95d0dd94d1bd6794715a165b763b",
         arm64_linux:  "e510091cff89ecebc741424f19f7546f0af33a9feae8849ef10442593a1287c8",
         x86_64_linux: "be8f2896ce0978300a02d894d967cb5673a6092d0f6e765ad232051cb5771d17"

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
