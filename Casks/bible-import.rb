cask "bible-import" do
  version "2024-05-05"
  sha256 "58325e5cbc499a80a05d4a700cd44ac8bfeae4001f1941917fe1a30e9b9e98a8"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.tar.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
