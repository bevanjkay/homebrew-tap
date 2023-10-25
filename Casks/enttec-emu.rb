cask "enttec-emu" do
  version "23.10.17.8"
  sha256 "345e306c42171b3fb769975fb5d1f0b6735088c3ff4eea7374206cba0feb5c6d"

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
