class Tvmv < Formula
  desc "Bulk-rename TV episode files with minimal fuss"
  homepage "https://github.com/keithfancher/tvmv"
  url "https://github.com/keithfancher/tvmv/archive/refs/tags/0.5.0.tar.gz"
  sha256 "5c668cef09a24bc2952fa2ec877a95016090b728c6f379f3a3b6f904dd275bc5"
  license "GPL-3.0"

  depends_on "ghc@9.4" => :build
  depends_on "haskell-stack" => :build

  def install
    stack_args = %w[
      --system-ghc
      --no-install-ghc
      --skip-ghc-check
    ]

    system "stack", "build", *stack_args
    system "stack", "install", *stack_args, "--local-bin-path=#{prefix}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tvmv -h")
  end
end
