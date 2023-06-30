cask "bome-midi-translator-pro" do
  version "1.9.0"
  sha256 "37436933ce487fbd4054277d94863ad3d244728263535cc61d900feba59440a6"

  url "https://download.bome.com/dl.php/27CB9388415F5/MIDITranslatorPro#{version}_Full.dmg"
  name "BOME MIDI Translator Pro"
  desc "MIDI Translator Application"
  homepage "https://www.bome.com/products/miditranslator"

  livecheck do
    url "https://www.bome.com/products/miditranslator/support/updates?v=#{version}&e=pro"
    regex(/The current version of MIDI Translator Pro is (\d+(?:\.\d+)+)/i)
  end

  app "Bome MIDI Translator Pro.app"

  zap trash: [
    "~/Library/Preferences/com.bome.miditranslator.pro.plist",
    "~/Library/Saved Application State/com.bome.miditranslator.pro.savedState",
  ]
end
