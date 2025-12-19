cask "t3-chat" do
  version "1.1.1"
  sha256 "f339fd44789cb2764d3ada6e78592c7142cd0882ab2dca5b122e426b768041e2"

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
