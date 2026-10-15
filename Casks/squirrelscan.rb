cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.113"
  sha256 arm:          "00449196a4bc3820de59e930be0dc43acb6b89774fb7a0070a71f45b1ec146e2",
         intel:        "55ccaa4db4a170bbc974a4c0850430d8cc32bf199ffd19992eca6913205b372c",
         arm64_linux:  "c432f5912f306291f6d343a565bec265e7438d95e98828f121f8097493f926c3",
         x86_64_linux: "0b1007dfa4706167cd6e4c95a59158547a4dcef7c8fa163bceae75449bc5914b"

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
