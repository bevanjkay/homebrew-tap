cask "mole-static" do
  version "1.46.0"
  sha256 "31a3616290e431a1834e1035d9d187c03296ee8f9ab471a8b368196d22115c47"

  url "https://raw.githubusercontent.com/tw93/mole/V#{version}/install.sh",
      verified: "raw.githubusercontent.com/tw93/mole/"
  name "Mole"
  desc "Deep clean and optimise your computer"
  homepage "https://github.com/tw93/Mole"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    installer script: {
      executable: "#{staged_path}/install.sh",
      args:       ["--prefix", staged_path.to_s],
      sudo:       true,
    }
    binary "mo"
    binary "mole"

    uninstall script: {
      executable: "mo",
      args:       ["remove"],
    }
  end

  # No zap stanza required
end
