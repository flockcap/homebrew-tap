class Cantrip < Formula
  desc "Speak plainly. Get the incantation. A beautiful, keyless shell companion."
  homepage "https://github.com/flockcap/cantrip"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.0/cantrip-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a69c24b73a96b8a2a65e2ba29e3accfa22d04b67e8fb98435ce441a07af9a59b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.0/cantrip-cli-x86_64-apple-darwin.tar.xz"
      sha256 "321052b5fadf4b46f9c8acd2a7bd193116e5265a46805440725720e651c851fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.0/cantrip-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f316b0a94784a2577d5a08f6a6a1873dcf794ef7e114d44e39f961de5b33118f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.0/cantrip-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c77b348f15a8ed8150e2e68dff8d3a3feeacb1c86a4aed4f70709112f1962d70"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cantrip"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cantrip"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cantrip"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cantrip"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
