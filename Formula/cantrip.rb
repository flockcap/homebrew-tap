class Cantrip < Formula
  desc "Speak plainly. Get the incantation. A beautiful, keyless shell companion."
  homepage "https://github.com/flockcap/cantrip"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.1/cantrip-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a770974b502b48eea3e5c0b0b851b8abe50131f7dde45d4deeb0c1e10abd0b5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.1/cantrip-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4d294ab4da18849916c7daef8bb24cd80e3386f9cff3f726208b1fe8834bbe1b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.1/cantrip-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c20c40f4c362f47e09e5b528064df003896610a780c452436b62196c9cbb19ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/flockcap/cantrip/releases/download/v0.1.1/cantrip-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "778c8b41bd4d9b1687721da182bb48212fd02992c50ff1de89127bd9ed12feae"
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
