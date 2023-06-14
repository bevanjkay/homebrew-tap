cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5950-beta-8dfdfbfe"
  sha256 arm:   "87bba3ec7366cadd797db1adcd881e814f70cba494b1e3f164e83c1847080fd4",
         intel: "4724a12eba81feab841854a5dfb2c46327e9dfbc2ee951c7ffc04082c87f2c19"

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
