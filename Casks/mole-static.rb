cask "mole-static" do
  version "1.58.0"
  sha256 "57c82bfeee4109dfb90c28b674fc4f405e6b4821362494af574451dffcd29b41"

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
