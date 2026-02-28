cask "mole-static" do
  version "1.28.1"
  sha256 "53a218c7bb64f9ffe0517d15d79818ab65ca3405389e97f22d54043d66bd910c"

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
  binary "mole"

  preflight do
    # Fix unbound variable error by expanding tmp directory in trap
    file = "#{staged_path}/install.sh"
    if File.exist?(file)
      content = File.read(file)
      content.gsub!("trap 'stop_line_spinner 2>/dev/null; rm -rf \"$tmp\"' EXIT",
                    "trap \"stop_line_spinner 2>/dev/null; rm -rf '$tmp'\" EXIT")
      File.write(file, content)
    end
  end

  uninstall script: {
    executable: "mo",
    args:       ["remove"],
  }

  # No zap stanza required
end
