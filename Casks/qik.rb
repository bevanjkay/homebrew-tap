cask "qik" do
  version "1.2.0"
  sha256 "ca16c67820acc79c088e41cc4fb848efa73258859241908e53607cab14591bb3"

  url "https://github.com/bevanjkay/pake-builder/releases/download/qik-#{version}/Qik.dmg",
      verified: "github.com/bevanjkay/pake-builder/"
  name "Qik"
  desc "Desktop application for Qik"
  homepage "https://qik.dev/"

  livecheck do
    url :url
    regex(/qik[._-]v?(\d+(?:\.\d+)+)/i)
  end

  app "Qik.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/Qik.app"
  end

  zap trash: "~/Library/Application Support/Qik"
end
