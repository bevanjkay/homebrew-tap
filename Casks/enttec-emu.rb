cask "enttec-emu" do
  version "25.07.07.5"
  sha256 "4e0eadc14db198a5804d9aa1d50ef2eb6e05edc81e7346e5625f74dfed85b5c4"

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
