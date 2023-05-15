class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202305151016.tar.gz"
  version "0.2+202305151016-1"
  sha256 "49a294ac41194559f6a59271fa9a15d457833e2ebc4bb3ed86121d567f89d4e9"

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
