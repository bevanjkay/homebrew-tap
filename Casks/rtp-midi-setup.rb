cask "rtp-midi-setup" do
  version :latest
  sha256 :no_check

  url "https://drive.google.com/uc?id=1esYiBe6Og7wlHYQQ87K8lQTzJkWf_F08&export=download "
  name "RTP MIDI Setup"
  desc "Sets up RTP MIDI connections automatically"
  homepage "https://drive.google.com/file/d/1esYiBe6Og7wlHYQQ87K8lQTzJkWf_F08/view"

  app "RTPMIDISetup.app"

  zap trash: [
    "~/Library/HTTPStorages/com.iConnectivity.RTPMIDISetup",
    "~/Library/Saved Application State/com.iConnectivity.RTPMIDISetup.savedState",
  ]
end
