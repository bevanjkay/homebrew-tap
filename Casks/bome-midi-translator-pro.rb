cask "bome-midi-translator-pro" do
  version "1.9.1,1064"
  sha256 "2fd942c76acaaa27fd203775d8713cf0cd832959d8493a2074c77bf56ed31cc2"

  url "https://download.bome.com/dl.php/3BE99E132EB23/MIDITranslatorPro#{version.csv.first}_Full.dmg"
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
