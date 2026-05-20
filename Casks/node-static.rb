cask "node-static" do
  version "26.2.0"
  sha256 "2d8c59df289ba651523d89df2e00ace61655ed468cef68c9a1c262250952c1fd"

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
