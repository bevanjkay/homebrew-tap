cask "mole-static" do
  version "1.44.0"
  sha256 "396630b066a526fa62e2710bbc06a6a73ddd2db63b8d2e2efc54203cfcf45e05"

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
