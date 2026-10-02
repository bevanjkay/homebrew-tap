cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.101"
  sha256 arm:          "56d50c3562835b9bb9b8ef14e3787bd4644b9a77d08aca094cb63e0811ce7ded",
         intel:        "c13533e8ab53259d0f3abca9ded06d6131332df47c09874363df2439ed76019d",
         arm64_linux:  "c80f23a4bff15e65d83f97391c8750f9331d467383524e9bdd146b8d3ca200a5",
         x86_64_linux: "ff3427026a0dff1036cd924aae083e7cf633ca51deb49938062bf9d70fad40b5"

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
