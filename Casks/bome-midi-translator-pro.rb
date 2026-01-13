cask "bome-midi-translator-pro" do
  version "1.9.2,1087"
  sha256 "e180ef47a4b814f151095fe0242cc817dedff71bbe35737cc5449ec1c4c61c39"

  url "https://download.bome.com/dl.php/21C2B86022897/MIDITranslatorPro#{version.csv.first}_Full.dmg"
  name "Bome MIDI Translator Pro"
  desc "MIDI Translator Application"
  homepage "https://www.bome.com/products/miditranslator"

  livecheck do
    url :homepage
    regex(/href=.*?MIDITranslatorProv?(\d+(?:\.\d+)+)[._-]Trial[._-](\d+)[._-]macOS\.dmg/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match.first},#{match.second}" }
    end
  end

  app "Bome MIDI Translator Pro.app"

  zap trash: [
    "~/Library/Preferences/com.bome.miditranslator.pro.plist",
    "~/Library/Saved Application State/com.bome.miditranslator.pro.savedState",
  ]
end
