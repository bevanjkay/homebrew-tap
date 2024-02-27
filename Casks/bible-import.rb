cask "bible-import" do
  version "2024-02-22"
  sha256 "5d00b2995da0078b059fe5064495f9189a33888ddb6a4d0b2f7cca1e01ef2b7e"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
