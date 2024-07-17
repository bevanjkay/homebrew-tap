cask "bible-import" do
  version "2024-07-17"
  sha256 "b73ca3d0e7253133f58b9dceef3b4844a90ebcc84e5bdfd1ab81f4859b99793d"

  url "https://github.com/martijnlentink/propresenter-custom-bibles/releases/download/#{version}/bible_import.OSX.tar.zip"
  name "ProPresenter Custom Bibles"
  desc "Create custom Bible translations for ProPresenter"
  homepage "https://github.com/martijnlentink/propresenter-custom-bibles"

  binary "bible_import", target: "bible-import"

  # No zap stanza required
end
