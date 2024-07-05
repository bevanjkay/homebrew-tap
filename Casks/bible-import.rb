cask "bible-import" do
  version "2024-05-24"
  sha256 "9780a59ae65be0a3efe7b2da41ec34900ef88950a3f5e95e9d8af8108e01a921"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.tar.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
