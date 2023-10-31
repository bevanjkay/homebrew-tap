cask "enttec-emu" do
  version "23.10.25.5"
  sha256 "4ac4b2676a5a1216516b25e19219c60f3fdb58e3995dc31bd725817a886cd0a3"

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
