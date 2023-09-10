class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202305160925.tar.gz"
  version "0.8.1+202305160925-1"
  sha256 "d79b6e1279f54cf0efa04f2c0698b16e46a2d0ff499c29856bcf9f49350412fa"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-gngeo-0.8.1+202305160925-1"
    sha256 monterey: "866fff959eb3921e56d13a0ea04f03bd5a52fb2045f0c70389fa93aef483a858"
    sha256 big_sur:  "5affc616c0f1cb1e190ec226f295cf745a46baf01ea1178518689f5c2a7a02b7"
  end

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "glew"
  depends_on "sdl2"

  def install
    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
                          "--program-prefix=ngdevkit-",
                          "CFLAGS=-I#{HOMEBREW_PREFIX}/include -Wno-implicit-function-declaration -DGNGEORC=\\\\\"ngdevkit-gngeorc\\\\\""
    system gmake, "pkgdatadir=#{share}/ngdevkit-gngeo"
    system gmake, "install", "pkgdatadir=#{share}/ngdevkit-gngeo"
  end

  test do
    # no test for the time being
    system "true"
  end
end
