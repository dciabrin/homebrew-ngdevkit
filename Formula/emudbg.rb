class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-20200120090612.tar.gz"
  sha256 "20acee9dd56dfd1f43b6032ef9f6793bb47e2db6aa24ced2a58d2b94cc030952"
  version "0.2+202001200758-1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
