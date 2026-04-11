cask "yarc-launcher" do
  version "1.3.0"
  sha256 "2cbf9e10630bbe73c77c8bd82b4c67a7f1e6b4ac45135ed28c2467cd1018510e"

  url "https://github.com/YARC-Official/YARC-Launcher/releases/download/v#{version}/YARC.Launcher_universal.app.tar.gz",
      verified: "github.com/YARC-Official/YARC-Launcher/"
  name "YARC Launcher"
  desc "Launcher for YARG (Yet Another Rhthym Game)"
  homepage "https://yarg.in/"

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
