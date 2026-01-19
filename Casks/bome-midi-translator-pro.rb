cask "bome-midi-translator-pro" do
  version "1.9.2,1090"
  sha256 "56d112b6d105d28ca533ff1ddf172d684bf5ab2a29291e48c738311a627d4c33"

  url "https://download.bome.com/dl.php/3BCB8B8705D79/MIDITranslatorPro#{version.csv.first}_Full.dmg"
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

  depends_on macos: ">= :big_sur"

  app "Bome MIDI Translator Pro.app"

  zap trash: [
    "~/Library/Preferences/com.bome.miditranslator.pro.plist",
    "~/Library/Saved Application State/com.bome.miditranslator.pro.savedState",
  ]
end
