class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202105012058.tar.gz"
  version "0.2+202105012058-1"
  sha256 "d60bbe1a548065f5a21fe5fda0e1f498913d80112de6f27e4957eea54e95b43b"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202105012058-1"
    sha256 cellar: :any_skip_relocation, catalina: "64b7f9e245d29f2db0cb5645be7f650aaa616e004f07aa2a6a20b0dbe5b1e699"
    sha256 cellar: :any_skip_relocation, mojave:   "ed42a8868e1314a5ce43f64a94522e7352f841eb78e3e42e1bb5582ee31ccdd3"
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
