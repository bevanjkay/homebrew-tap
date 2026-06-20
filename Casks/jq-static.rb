cask "jq-static" do
  arch arm: "arm64", intel: "amd64"
  os macos: "macos", linux: "linux"

  version "1.8.2"
  sha256 arm:          "2d75340ba57a4b4b4c8708a21c2dc8e958a48aaa8bba13b27f77f6e4c0eca07e",
         intel:        "e94b266e3c26690550006abe63152b782280f4e14374accdf04cbde844f00bc0",
         x86_64_linux: "b1c22172dd303f3be49e935aa56aa48a8b7a46e0bc838b4997d3bb451495870f",
         arm64_linux:  "8b85c817833814ddca00a144c33705546355afccf0cf39b188f3cdb48b852309"

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
