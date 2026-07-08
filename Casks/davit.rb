cask "davit" do
  version "0.1.10"
  sha256 "68d3b2565f39eb4fdb71a8afb12f30ba2333b8a459d0367d5d6d06c836720669"

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
