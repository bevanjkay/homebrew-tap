cask "pro7-media-sweeper" do
  version "2.3.3"
  sha256 "20e805856d0ade3ef5f7670d8bb72c3ad8a71eac3f829b7aaf75c62a478bf817"

  url "https://github.com/arlinsandbulte/Pro7-Media-Sweeper/releases/download/v#{version}/Pro7.Media.Sweeper.Mac.v#{version}.zip"
  name "Pro7 Media Sweeper"
  desc "Find and sweep orphaned media files that are not being used by ProPresenter7"
  homepage "https://github.com/arlinsandbulte/Pro7-Media-Sweeper"

  depends_on macos: [
    ":sonoma",
    ":sequoia",
  ]

  app "Pro7 Media Sweeper.app"

  zap trash: "~/Library/Saved Application State/Pro7 Media Sweeper.savedState",
      rmdir: "~/Pro7 Media Sweeper"
end
