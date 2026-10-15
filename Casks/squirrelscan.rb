cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.114"
  sha256 arm:          "1324ea7317a81a286f785754f35f67bc3c3dffd484d3d75d380c2001b71168c5",
         intel:        "e06435e05953206ebee010c166058331a40bbb0901f7a05ab0ec88ec487caed5",
         arm64_linux:  "f0ebfbc3f015f441d308656113719a5209b8887c17ee2f540f14503239d7dbe2",
         x86_64_linux: "d5fb19ecf0f4dbf92235974cf5a8419fe46f427181e9582615728ecabed93b1f"

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
