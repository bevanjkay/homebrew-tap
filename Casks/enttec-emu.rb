cask "enttec-emu" do
  version "26.04.17.5"
  sha256 "a6a428b99c40f784fa4b9a875bd13281c6711dad5d5639a2142c0a3e31969d7b"

  url "https://s3-us-west-2.amazonaws.com/enttec-software-builds/emu/EMU-#{version}.pkg",
      verified: "s3-us-west-2.amazonaws.com/enttec-software-builds/emu/"
  name "ENTTEC Emu"
  desc "Setup and manage ENTTEC DMX devices"
  homepage "https://www.enttec.com.au/product/dmx-lighting-control-software/emu-sound-to-light-controller/"

  livecheck do
    url "https://s3-us-west-2.amazonaws.com/enttec-software-builds/emu/emu-versions.json"
    strategy :json do |json|
      json["EMU"].filter_map do |version|
        next unless version["Stages"]&.any?("Production")

        version["VersionNumber"]
      end
    end
  end

  pkg "EMU-#{version}.pkg"

  uninstall pkgutil: [
    "com.enttec.emu",
    "com.enttec.emu.au",
    "com.enttec.emu.vst3",
  ]

  zap trash: "~/Library/Preferences/com.enttec.emu.plist"
end
