cask "bartender@pinned" do
  version "5.0.51"
  sha256 "6d5a7c3fd97b0014e9d07284e9a470e817a1e899128469a3c9a954275a1cabfd"

  url "https://www.macbartender.com/B2/updates/#{version.dots_to_hyphens}/Bartender%20#{version.major}.dmg"
  name "Bartender"
  desc "Menu bar icon organiser"
  homepage "https://www.macbartender.com/"

  livecheck do
    skip "Version pinned"
  end

  auto_updates true
  conflicts_with cask: "bartender"
  depends_on macos: ">= :sonoma"

  app "Bartender #{version.major}.app"

  uninstall launchctl: "com.surteesstudios.Bartender.BartenderInstallHelper",
            quit:      "com.surteesstudios.Bartender",
            delete:    [
              "/Library/Audio/Plug-Ins/HAL/BartenderAudioPlugIn.plugin",
              "/Library/PrivilegedHelperTools/com.surteesstudios.Bartender.BartenderInstallHelper",
              "/Library/ScriptingAdditions/BartenderHelper.osax",
              "/System/Library/ScriptingAdditions/BartenderSystemHelper.osax",
            ]

  zap trash: [
    "~/Library/Caches/com.surteesstudios.Bartender",
    "~/Library/Cookies/com.surteesstudios.Bartender.binarycookies",
    "~/Library/Preferences/com.surteesstudios.Bartender.plist",
  ]
end
