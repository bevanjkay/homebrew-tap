cask "bible-import" do
  version "2024-04-28"
  sha256 "252ce8bb6e79ab2f9e33b86d1ce0445aa1248d02503f9c643a1871c622bdc278"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.tar.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
