cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.117"
  sha256 arm:          "4b8d3decbcbbe3348d29608c9ae0174462c6e1fa9c2d13c2dfa5c07df33490e9",
         intel:        "ee263a20a5ced85ac4420eeca64e887fa942388a592a23b31c36a68372b197bb",
         arm64_linux:  "c30d5d341717b611396e6fb31b30f4f615cd9d5fb7305eadb5397b4300019d9a",
         x86_64_linux: "e7913b8f6da048340949db54680fec8932b6148a1972f03324098c08b8b6e938"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr",
          args:         ["-d", "com.apple.quarantine", "{{staged_path}}/squirrel-{{version}}-darwin-{{arch}}"],
          must_succeed: false
    end
  end

  zap trash: "~/.squirrel"
end
