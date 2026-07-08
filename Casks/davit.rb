cask "davit" do
  version "0.1.11"
  sha256 "86d64e8dfe7754f87e9d0886156f026725d5287aa09dc40751dea0e7791dc9b1"

  url "https://github.com/wouterdebie/davit/releases/download/v#{version}/Davit-#{version}.zip"
  name "Davit"
  desc "GUI for Apple's container CLI"
  homepage "https://github.com/wouterdebie/davit"

  depends_on macos: :sequoia

  app "Davit.app"

  zap trash: [
    "~/Library/Caches/dev.wouter.davit",
    "~/Library/HTTPStorages/dev.wouter.davit",
    "~/Library/Preferences/dev.wouter.davit.plist",
  ]
end
