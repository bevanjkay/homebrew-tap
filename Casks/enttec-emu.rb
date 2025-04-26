cask "enttec-emu" do
  version "25.04.17.2"
  sha256 "82f6b1816a300d9dfb93a336d8466e3aa02457e0d9b34fc9cb1b45ea41af0d66"

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
