cask "allen-and-heath-midi-control" do
  version "2.20,2025,06"
  sha256 "5396e21f51a9f951b0582435716e7dda1e93a2b20ddb20e7fe2a1ba4ae134756"

  url "https://www.allen-heath.com/content/uploads/#{version.csv.second}/#{version.csv.third}/Allen-and-Heath-MIDI-Control-V#{version.csv.first}-Mac.zip",
      user_agent: :browser
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

  container nested: "Allen and Heath MIDI Control #{version.csv.first.chomp("0")}.dmg"

  app "Allen and Heath MIDI Control.app"

  zap trash: [
    "~/Library/Preferences/com.allenheath.midicontrol.plist",
    "~/Library/Preferences/com.com-allenheath.MIDI Control.plist",
  ]

  caveats do
    requires_rosetta
  end
end
