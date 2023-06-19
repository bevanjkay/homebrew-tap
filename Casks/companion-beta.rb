cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5965-beta-1b7c4339"
  sha256 arm:   "13a95d0d73a89d5e1556235aaba2525043a737633126e19087ba4df6146728dc",
         intel: "d62ad3997c2f1b90cbd6f18142ffe95b0521cf8d900922034696a0f6849aaeda"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=beta&limit=150"
    strategy :json do |json|
      json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["version"] }
    end
  end

  auto_updates true

  app "Companion.app", target: "Companion Beta.app"

  postflight do
    system "open", "/Applications/Companion Beta.app" if ENV["HOMEBREW_OPEN_AFTER_INSTALL"]
  end

  uninstall quit: [
    "companion.bitfocus.no",
    "test-companion.bitfocus.no",
  ]
end
