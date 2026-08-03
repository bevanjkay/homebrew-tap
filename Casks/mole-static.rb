cask "mole-static" do
  version "1.49.2"
  sha256 "74d085fc3428b548d657b28dc81bef7ea302d18444434915124bb2c381c9086b"

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

  # install.sh cleans up with safe_rm, which gates on TMPDIR, but `mktemp -d`
  # ignores TMPDIR on macOS and brew filters it out of the environment. Without
  # a matching TMPDIR the cleanup refuses the path and the script exits 1 after
  # an otherwise successful install. Upstream: tw93/mole.
  installer script: {
    executable: "/bin/bash",
    args:       [
      "-c",
      "TMPDIR=\"$(getconf DARWIN_USER_TEMP_DIR)\" exec /bin/bash \"$0\" --prefix \"$1\"",
      "#{staged_path}/install.sh",
      staged_path.to_s,
    ],
  }
  binary "mo"
  binary "mole"

  uninstall script: {
    executable: "mo",
    args:       ["remove"],
  }

  # No zap stanza required
end
