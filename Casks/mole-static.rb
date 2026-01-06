cask "mole-static" do
  version "1.19.0"
  sha256 "2d87022a9a0cfdc3eb33317404352cd4dbc0aae7ef68b311becca212752d990e"

  url "https://raw.githubusercontent.com/tw93/mole/V#{version}/install.sh",
      verified: "raw.githubusercontent.com/tw93/mole/"
  name "Mole"
  desc "Deep clean and optimise your computer"
  homepage "https://github.com/tw93/Mole"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  installer script: {
    executable: "#{staged_path}/install.sh",
    args:       ["--prefix", staged_path.to_s],
    sudo:       true,
  }
  binary "mo"

  uninstall script: {
    executable: "mo",
    args:       ["remove"],
  }

  # No zap stanza required
end
