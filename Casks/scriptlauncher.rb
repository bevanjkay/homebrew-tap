cask "scriptlauncher" do
  arch arm: "silicon", intel: "intel"

  version "1.9.0"
  sha256 arm:   "66e426d60c6965dd27e8625b703b0e4b5bece3e3b7e82e5570a57fcc51739c45",
         intel: "ede696c4d9be07e6616a952f2a7006fe859c80bde4216b31b8082e1211f9a107"

  url "https://github.com/josephdadams/ScriptLauncher/releases/download/v#{version}/scriptlauncher-mac-#{arch}-#{version}.dmg"
  name "ScriptLauncher"
  desc "Run scripts on your machine"
  homepage "https://github.com/josephdadams/ScriptLauncher"

  depends_on macos: ">= :big_sur"

  app "scriptlauncher.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.josephadams.scriptlauncher.sfl*",
    "~/Library/Application Support/scriptlauncher",
    "~/Library/Preferences/com.josephadams.scriptlauncher.plist",
  ]
end
