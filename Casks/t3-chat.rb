cask "t3-chat" do
  version "1.0.0"
  sha256 "41415e065013875e31137f7e13c9317c9e429c6699109d6da64f0d9ecf24054a"

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
