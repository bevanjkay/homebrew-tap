cask "mole-static" do
  version "1.59.0"
  sha256 "5fae246355a1ff237beaf945e9d9778c49b743293095eb54d8cb7b7a5327f727"

  url "https://raw.githubusercontent.com/tw93/mole/V#{version}/install.sh"
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
  }
  binary "mo"
  binary "mole"

  uninstall script: {
    executable: "mo",
    args:       ["remove"],
  }

  # No zap stanza required
end
