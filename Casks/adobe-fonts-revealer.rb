cask "adobe-fonts-revealer" do
  version "20240422,70364ff58539081f000ded8fa70018628860397d"
  sha256 :no_check

  url "https://github.com/Kalaschnik/adobe-fonts-revealer.git",
      branch: "main"
  name "Adobe Fonts Revealer"
  desc "Turn Adobe Fonts into local fonts"
  homepage "https://github.com/Kalaschnik/adobe-fonts-revealer"

  livecheck do
    url "https://api.github.com/repos/Kalaschnik/adobe-fonts-revealer/commits/main"
    strategy :json do |json|
      date = DateTime.parse(json["commit"]["committer"]["date"]).strftime("%Y%m%d")
      "#{date},#{json["sha"]}"
    end
  end

  depends_on formula: "lcdf-typetools"

  binary "reveal", target: "adobe-fonts-revealer"

  # No zap stanza required
end
