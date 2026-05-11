cask "mole-static" do
  version "1.38.1"
  sha256 "19b67bf2b39bfd9895bf159b1e66622093764428ff0751e2fd492913bfcee73a"

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
