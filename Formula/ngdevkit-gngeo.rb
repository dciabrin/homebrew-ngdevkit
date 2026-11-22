class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/refs/tags/nightly-202611221114.tar.gz"
  version "0.8.1+202611221114-1"
  sha256 "b4632db9e962a711f50d3bf98ff9f71766ea8bcb6d6351b084bdb108e277fe96"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-gngeo-0.8.1+202611221114-1"
    sha256 arm64_golden_gate: "3d9bef0f506a494f0911347421e27d69abb7963ecc92dab079e28a11cd66d989"
    sha256 arm64_tahoe:       "505de74fe17e1a01528c812565068dd526c064f1a1c3a1991f190d027509f893"
  end

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "glew"
  depends_on "sdl2"
  depends_on "sdl2-compat"

  def install
    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{formula_opt_bin("make")}/gmake"
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
                          "CFLAGS=-I#{HOMEBREW_PREFIX}/include -Wno-implicit-function-declaration " \
                          "-DGNGEORC=\\\\\"ngdevkit-gngeorc\\\\\""
    system gmake, "pkgdatadir=#{share}/ngdevkit-gngeo"
    system gmake, "install", "pkgdatadir=#{share}/ngdevkit-gngeo"
  end

  test do
    # no test for the time being
    system "true"
  end
end
