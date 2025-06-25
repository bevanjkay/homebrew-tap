cask "node-static" do
  version "24.3.0"
  sha256 "5d26dfb26af1b65ce3c739695425da4f215d560d69b43d1845ecd34b029860c7"

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
