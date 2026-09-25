cask "mole-static" do
  version "1.56.0"
  sha256 "f54a88abcda72c4820be06f73630412aa691ea8a74cf58acbc5c88f2ba178e16"

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
