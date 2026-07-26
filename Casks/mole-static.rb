cask "mole-static" do
  version "1.48.1"
  sha256 "682ceded63ba42a89aff4e4ee0886d7de097fa0b72ba9c2e2faf8e03ca4ff40f"

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
