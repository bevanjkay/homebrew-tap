cask "enttec-emu" do
  version "23.11.01.1"
  sha256 "46ea44d3690439d06788ed2561c66c8549dce29575334c66c8886221cfa9bcc8"

  url "https://s3-us-west-2.amazonaws.com/enttec-software-builds/emu/EMU-#{version}.pkg",
      verified: "s3-us-west-2.amazonaws.com/enttec-software-builds/emu/"
  name "ENTTEC Emu"
  desc "Setup and manage ENTTEC DMX devices"
  homepage "https://www.enttec.com.au/product/dmx-lighting-control-software/emu-sound-to-light-controller/"

  livecheck do
    url "https://s3-us-west-2.amazonaws.com/enttec-software-builds/emu/emu-versions.json"
    regex(/EMU[._-]v?(\d+(?:\.\d+)+)\.pkg","Stages":\["Beta","Production/i)
  end

  pkg "EMU-#{version}.pkg"

  uninstall pkgutil: [
    "com.enttec.emu.au",
    "com.enttec.emu.vst3",
    "com.enttec.emu",
  ]

  zap trash: "~/Library/Preferences/com.enttec.emu.plist"
end
