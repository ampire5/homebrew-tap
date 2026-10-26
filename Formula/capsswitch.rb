class Capsswitch < Formula
  desc "Caps Lock switches between the two most recent keyboard layouts, instantly"
  homepage "https://github.com/ampire5/capsswitch"
  url "https://github.com/ampire5/capsswitch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "89cbee35c5ce470f391435e839b956f3d493fbab9fa8a56520af0e1cfcf29cdb"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "main.swift", "-o", "capsswitch"
    bin.install "capsswitch"
  end

  service do
    run opt_bin/"capsswitch"
    keep_alive true
    process_type :interactive
  end

  test do
    assert_match "indicator:", shell_output("#{bin}/capsswitch indicator")
  end
end
