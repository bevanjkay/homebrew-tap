cask "t3-chat" do
  version "1.0.2"
  sha256 "82fa652dd126f06f065f2864092afa956d6ddd0505ba884132b59852e85acbc6"

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

  zap trash: [
    "~/Library/Application Support/T3 Chat",
    "~/Library/Application Support/T3Chat",
  ]
end
