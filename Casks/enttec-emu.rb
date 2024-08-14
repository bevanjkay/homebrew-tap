cask "enttec-emu" do
  version "24.08.01.6"
  sha256 "d20ec9122c6034c35410fdb8383d5ceb91c82e963b08ada1891483d2a4e6e9c0"

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
