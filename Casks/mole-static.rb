cask "mole-static" do
  version "1.61.0"
  sha256 "b389c3cf20cdb707b570b7d52ecc6b2e035d13ddf59aef103eca24426753ddb1"

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
