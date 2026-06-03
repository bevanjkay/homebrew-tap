cask "mole-static" do
  version "1.41.0"
  sha256 "24559864864be8f05093461600e7a67b6f61d1f5131a58b587e1c3245710f90b"

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
