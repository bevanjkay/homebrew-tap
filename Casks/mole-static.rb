cask "mole-static" do
  version "1.68.0"
  sha256 "55bffa6b1c0828481d09acaaae1525e0c08e5be33d79fd91ebfd35979ecdd2e1"

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

  zap :not_required
end
