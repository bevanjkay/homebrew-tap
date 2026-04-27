cask "mole-static" do
  version "1.36.2"
  sha256 "22bfdfd446ee9de6bea1322e59118b4d16e2ee1a18a25884c21584c47c719b83"

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
