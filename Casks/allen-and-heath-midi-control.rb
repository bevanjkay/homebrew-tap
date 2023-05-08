cask "allen-and-heath-midi-control" do
  version "2.01"
  sha256 "4479564b5cac657ce166704083702a04738b7e152fc89ee79413ab6fa7299bbf"

  url "https://www.allen-heath.com/media/Allen-and-Heath-MIDI-Control-#{version}-Mac.zip"
  name "Allen & Heath Midi Control"
  desc "Midi control software for Allen & Heath audio consoles"
  homepage "https://www.allen-heath.com/midi-control/"

  livecheck do
    url :homepage
    regex(/A&H\s*MIDI\s*Control\s*v?(\d+(?:\.\d+)+)[< "]/i)
  end

  container nested: "Allen and Heath MIDI Control #{version}.dmg"

  app "Allen and Heath MIDI Control.app"

  zap trash: [
    "~/Library/Preferences/com.allenheath.midicontrol.plist",
    "~/Library/Preferences/com.com-allenheath.MIDI Control.plist",
  ]
end
