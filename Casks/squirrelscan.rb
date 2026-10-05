cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.103"
  sha256 arm:          "bbc5f29dd4177d85e6b276ae6cae1f111f3e604c08ee459b6f1f45618bae49ac",
         intel:        "9021813e172ee237056770c49c3def5ec12579d67c09d862cd379d004d8177c0",
         arm64_linux:  "b275008e75320d122bbd6b56d201625d73f19bd0f093ea8d6647cd3649171eb1",
         x86_64_linux: "05bea7c1646e30ae868056f9809e49d602372f2f8f876f8b36959e867559bb0f"

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
