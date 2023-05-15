class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202305151016.tar.gz"
  version "0.2+202305151016-1"
  sha256 "49a294ac41194559f6a59271fa9a15d457833e2ebc4bb3ed86121d567f89d4e9"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202305151016-1"
    sha256 cellar: :any_skip_relocation, monterey: "68d21cf54eae5147a345143e7ba6a21c9cb8a68774e5903195332a120d2bd23d"
    sha256 cellar: :any_skip_relocation, big_sur:  "7355aac55ade6d70ac4815ef46e61a65b3141f750616d9325f3734cf73a2de57"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
