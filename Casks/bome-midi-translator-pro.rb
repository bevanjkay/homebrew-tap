cask "bome-midi-translator-pro" do
  version "1.9.1"
  sha256 "e618e982b87ccd78dc35f2dac86c413dc86b8631fb02f7703e4a79c4e22dfd66"

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
