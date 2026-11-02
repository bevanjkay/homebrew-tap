cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.159"
  sha256 arm:          "8de0d032afd99ce65bbebf8d665f03eb4e0201152d78030b8e3ff0a7bb8bc8f5",
         intel:        "35629e50208dad75f54f1951da0426e71bfbef87cb0a1a2fb0c653dfc7eb67a4",
         arm64_linux:  "a7395ec0e9fbd8f5f976037848c5e7c6a5607ffe37113c209c4d6970a6308bb0",
         x86_64_linux: "c3c2ee131292a4f9be224e2f0593d46d6fee71164610633a67c16ce0b7321cb7"

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
