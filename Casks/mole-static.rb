cask "mole-static" do
  version "1.26.0"
  sha256 "a0ba9537842d68c9ef6f4d30f4a5406a10e514ed39743e06089341a9d3545f0f"

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
