class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111141535.tar.gz"
  version "0.2+202111141535-2"
  sha256 "5ac567efdca679dc46854581d87ab6f9b88fc920adbd1896cdb32c1dd233a443"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111141535-2"
    sha256 cellar: :any_skip_relocation, monterey: "901669c136ca7b3bdfa0b4a68bed135ddbe1e6c94e04ce326ea4eab91b48f73b"
    sha256 cellar: :any_skip_relocation, big_sur:  "b0dd77eb09a000d5e7ea5be78e01467caf95c1f8f49751e689c1a6ee8e51247e"
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
