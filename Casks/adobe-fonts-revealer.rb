cask "adobe-fonts-revealer" do
  version "20230624,8d02879ef8a6679e5c9cf09fb0ab4168e0e44341"
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
