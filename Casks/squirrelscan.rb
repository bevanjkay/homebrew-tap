cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.98"
  sha256 arm:          "11fd463b13b90194374c3e3f286913737afe55e46f3d46358c5655a7a6cb1eeb",
         intel:        "29aa21b69fddbd7a737c5a87e61d93927b219fecbfdf0ec3f971fdb629166274",
         arm64_linux:  "50eae6878b61c0d0841719c51eac52151b20e8c5c83b42ad3cdb72edbd9f9546",
         x86_64_linux: "679fd4a133527699ae66993a8f61d905bc0d304a42c41cf87b141ca1cca3303f"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr",
          args:         ["-d", "com.apple.quarantine", "{{staged_path}}/squirrel-{{version}}-darwin-{{arch}}"],
          must_succeed: false
    end
  end

  zap trash: "~/.squirrel"
end
