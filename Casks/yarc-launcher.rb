cask "yarc-launcher" do
  version "1.2.0"
  sha256 "f63e6cff4b4f129b896ff8dd0cc505423c3e79e7666761cb98143cddbcd55763"

  url "https://github.com/YARC-Official/YARC-Launcher/releases/download/v#{version}/YARC.Launcher_universal.app.tar.gz",
      verified: "github.com/YARC-Official/YARC-Launcher/"
  name "YARC Launcher"
  desc "Launcher for YARG (Yet Another Rhthym Game)"
  homepage "https://yarg.in/"

  depends_on macos: ">= :high_sierra"

  app "YARC Launcher.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "/Applications/YARC Launcher.app"
  end

  zap trash: [
    "~/Library/Application Support/in.yarg.game",
    "~/Library/Application Support/in.yarg.launcher",
    "~/Library/Application Support/YARC",
    "~/Library/Caches/in.yarg.launcher",
    "~/Library/Logs/in.yarg.launcher",
    "~/Library/Logs/YARC",
    "~/Library/Preferences/in.yarg.game.plist",
    "~/Library/Saved Application State/in.yarg.game.savedState",
    "~/Library/Saved Application State/in.yarg.launcher.savedState",
    "~/Library/WebKit/in.yarg.launcher",
  ]
end
