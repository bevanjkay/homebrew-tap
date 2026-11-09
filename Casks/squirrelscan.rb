cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.173"
  sha256 arm:          "5d57dc6ccbd6a4997ddd2f886e06e64b0d41f960a940473e14817dae76449142",
         intel:        "9e0d98e83ad9460b8278fd2fab05d2a66e76c8dc554c12fb251a330b834e9cc8",
         arm64_linux:  "19a3f1fadc89973a09f9ba51427446bfe42ec0b2f2a3e20c1a514464a5f88157",
         x86_64_linux: "f8e442143343fa41799c7e4fb38578e0808960e6ddeef8568ca2af7c5772c6eb"

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
