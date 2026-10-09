cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.106"
  sha256 arm:          "cb597d17b87676951004ab12653e44af6cd95149334efb6413a71c30f6bc1606",
         intel:        "d7996ba2aea7a456791da1d93589bd854eafb5ef0db19655e47aa0e44798859d",
         arm64_linux:  "3f8e656a66e02a15a82650e760c14c170b2e30db48bb0067a13e8c690505f4ae",
         x86_64_linux: "a456793a3d39d28e9dd2ea2e8dc6275c23bfbd86de912821726ae3defb3afd31"

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
