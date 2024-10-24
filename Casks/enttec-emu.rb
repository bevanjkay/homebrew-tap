cask "enttec-emu" do
  version "24.10.07.5"
  sha256 "8ce4903b1bd27b9f2dfdbd73b8ba29bd59e5ac54c71facbe7b6f2f806c19927b"

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
    "com.enttec.emu",
    "com.enttec.emu.au",
    "com.enttec.emu.vst3",
  ]

  zap trash: "~/Library/Preferences/com.enttec.emu.plist"
end
