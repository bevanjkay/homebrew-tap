cask "node-static" do
  version "26.8.2"
  sha256 "da3c491e86e4ade2b2856301de365765e6cb29aea442c7158b40246eda021c72"

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
