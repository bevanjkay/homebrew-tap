cask "mole-static" do
  version "1.49.0"
  sha256 "8df22814bed9ac71a37f235448f99b73c77cc1b5790f864a1c24ac24a7df1d82"

  url "https://raw.githubusercontent.com/tw93/mole/V#{version}/install.sh",
      verified: "raw.githubusercontent.com/tw93/mole/"
  name "Mole"
  desc "Deep clean and optimise your computer"
  homepage "https://github.com/tw93/Mole"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on :macos

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

  # No zap stanza required
end
