cask "adobe-fonts-revealer" do
  version :latest
  sha256 :no_check

  url "https://github.com/Kalaschnik/adobe-fonts-revealer.git",
      branch:   "main"
  name "Adobe Fonts Revealer"
  desc "Turn Adobe Fonts into local fonts"
  homepage "https://github.com/Kalaschnik/adobe-fonts-revealer"

  depends_on formula: "lcdf-typetools"

  binary "reveal", target: "adobe-fonts-revealer"

  # No zap stanza required
end
