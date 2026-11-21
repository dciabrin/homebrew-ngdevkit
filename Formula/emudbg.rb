class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/refs/tags/nightly-202611211244.tar.gz"
  version "0.2+202611211244-1"
  sha256 "d5da4edb714ae6959f50e63a5d3485c0c44ea6a6dcbc1881e964a741cd5bfcff"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{formula_opt_bin("make")}/gmake"
    ENV["MAKE"] = gmake

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
