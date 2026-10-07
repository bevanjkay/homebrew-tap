cask "node-static" do
  version "26.11.0"
  sha256 "994cf7dcd044781f1ab67190ba30da16d8d48d81f111edb81c0845ea24a79142"

  url "https://nodejs.org/dist/v#{version}/node-v#{version}.pkg"
  name "Node"
  desc "Platform built on V8 to build network applications"
  homepage "https://nodejs.org/"

  livecheck do
    url "https://nodejs.org/dist/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  depends_on :macos

  pkg "node-v#{version}.pkg"

  uninstall pkgutil: [
    "org.nodejs.node.pkg",
    "org.nodejs.npm.pkg",
  ]

  # No zap stanza required
end
