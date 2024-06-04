cask "allen-and-heath-midi-control" do
  version "2.10,2024,06"
  sha256 "8b6aed7ce59b295ac27c4f4c7d3d9058b1aea909ddd90ced9105d62158ee98bb"

  url "https://www.allen-heath.com/content/uploads/#{version.csv.second}/#{version.csv.third}/Allen-and-Heath-MIDI-Control-#{version.csv.first}-Mac.zip"
  name "Allen & Heath Midi Control"
  desc "Midi control software for Allen & Heath audio consoles"
  homepage "https://www.allen-heath.com/midi-control/"

  livecheck do
    url "https://www.allen-heath.com/hardware/controllers/midi-control/resources/"
    regex(%r{href=.*?/([^/]+)/([^/]+)/Allen-and-Heath-MIDI-Control[._-]v?(\d+(?:\.\d+)+)(?:-Mac)?\.zip}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match.third},#{match.first},#{match.second}" }
    end
  end

  container nested: "Allen and Heath MIDI Control #{version.csv.first}.dmg"

  app "Allen and Heath MIDI Control.app"

  zap trash: [
    "~/Library/Preferences/com.allenheath.midicontrol.plist",
    "~/Library/Preferences/com.com-allenheath.MIDI Control.plist",
  ]
end
