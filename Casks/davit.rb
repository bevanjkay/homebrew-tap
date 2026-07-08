cask "davit" do
  version "0.1.7"
  sha256 "50bce8ab2dbf5ea798d4f4441f87be7c207fc43248b0835e1382c884f879b58d"

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
