cask "t3-chat" do
  version "1.1.0"
  sha256 "ba45f86ca059d3a49762fd0c5dc623b0b7aea19b0646f88e7c59853db7eb4ea7"

  url "https://github.com/bevanjkay/pake-builder/releases/download/t3-chat-#{version}/T3.Chat.dmg",
      verified: "github.com/bevanjkay/pake-builder/"
  name "T3 Chat"
  desc "AI chat tool"
  homepage "https://t3.chat/"

  livecheck do
    url :url
    regex(/t3-chat[._-]v?(\d+(?:\.\d+)+)/i)
  end

  app "T3 Chat.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/T3 Chat.app"
  end

  zap trash: [
    "~/Library/Application Support/T3 Chat",
    "~/Library/Application Support/T3Chat",
  ]
end
