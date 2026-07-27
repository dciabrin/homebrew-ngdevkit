class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/refs/tags/nightly-202607271849.tar.gz"
  version "0.8.1+202607271849-2"
  sha256 "230e198e27e5f9ffc683a3f85097403c27110609879e2a84fa43c23472b8c3a2"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-gngeo-0.8.1+202607271849-2"
    sha256 arm64_sequoia: "9e54ecc112589f256dd3329c187293854082a5ba40be9bfdaf9c4ebc47e501b2"
    sha256 arm64_sonoma:  "5241b93550451c8c3205fb70fa18d823e172b1bf8d07fd36dd791894561fa951"
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
