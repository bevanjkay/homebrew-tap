cask "bome-midi-translator-pro" do
  version "1.9.1"
  sha256 "aae0323c71ad2e25f16a64f9056114c7889a9577d4ba6393b1d075c503c0c34d"

  url "https://download.bome.com/dl.php/3ACFDF73C03CB/MIDITranslatorPro#{version}_Full.dmg"
  name "Bome MIDI Translator Pro"
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
