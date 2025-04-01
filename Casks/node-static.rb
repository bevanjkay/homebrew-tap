cask "node-static" do
  version "23.11.0"
  sha256 "951ca83a4b4c70686019f88761b5ac6096519ae5e113add8cdffa45b839307d4"

  url "https://nodejs.org/dist/v#{version}/node-v#{version}.pkg"
  name "Node"
  desc "Platform built on V8 to build network applications"
  homepage "https://nodejs.org/"

  livecheck do
    url "https://nodejs.org/dist/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  pkg "node-v#{version}.pkg"

  uninstall pkgutil: [
    "org.nodejs.node.pkg",
    "org.nodejs.npm.pkg",
  ]

  # No zap stanza required
end
