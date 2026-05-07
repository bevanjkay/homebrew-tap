cask "jq-static" do
  arch arm: "arm64", intel: "amd64"
  os macos: "macos", linux: "linux"

  version "1.8.1"
  sha256 arm:          "a9fe3ea2f86dfc72f6728417521ec9067b343277152b114f4e98d8cb0e263603",
         intel:        "e80dbe0d2a2597e3c11c404f03337b981d74b4a8504b70586c354b7697a7c27f",
         x86_64_linux: "020468de7539ce70ef1bceaf7cde2e8c4f2ca6c3afb84642aabc5c97d9fc2a0d",
         arm64_linux:  "6bc62f25981328edd3cfcfe6fe51b073f2d7e7710d7ef7fcdac28d4e384fc3d4"

  on_intel do
    postflight do
      system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/jq"
    end
  end

  url "https://github.com/jqlang/jq/releases/download/jq-#{version}/jq-#{os}-#{arch}",
      verified: "github.com/jqlang/jq/"
  name "jq"
  desc "JSON processor"
  homepage "https://jqlang.github.io/jq/"

  binary "jq-#{os}-#{arch}", target: "jq"

  # No zap stanza required
end
