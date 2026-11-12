cask "bitwarden-accelerator" do
  version "8.4.0"
  sha256 "264c4a95113893906ad41704b64dfe6cdd637d170300cb213e0f8fc3ff719eb3"

  url "https://github.com/ajrosen/Bitwarden-Accelerator/releases/download/bwa-#{version}/Bitwarden.Accelerator.alfredworkflow"
  name "Bitwarden Accelerator"
  desc "Alfred workflow for Bitwarden"
  homepage "https://github.com/ajrosen/Bitwarden-Accelerator"

  livecheck do
    url :url
    regex(/^bwa[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on :macos
  container type: :naked

  installer manual: "Bitwarden.Accelerator.alfredworkflow"

  uninstall launchctl: "org.mlfs.corp.bw",
            delete:    "~/Library/LaunchAgents/org.mlfs.corp.bw.plist"

  zap trash: [
    "~/Library/Application Support/Alfred/Workflow Data/org.mlfs.corp.bw",
    "~/Library/Caches/com.runningwithcrayons.Alfred/Workflow Data/org.mlfs.corp.bw",
  ]
end
