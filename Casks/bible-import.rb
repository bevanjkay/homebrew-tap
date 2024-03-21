cask "bible-import" do
  version "2024-03-21"
  sha256 "caa05039b8713255732757ad92a838b0c9875aefce9a724370280b08c6f91bba"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.tar.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
