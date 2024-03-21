cask "bible-import" do
  version "2024-03-20"
  sha256 "4bca2cbf85f1554d7c016b19099433d063895d2ed5d82c265a2c0dc0c01a8733"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.tar.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
