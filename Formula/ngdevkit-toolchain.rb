class NgdevkitToolchain < Formula
  desc "Toolchain for ngdevkit"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/refs/tags/nightly-202501031114.tar.gz"
  version "0.1+202501031114-1"
  sha256 "7cd1f5da1dcffcbaf4e741846ef8494c91bf32c1c270b7efee5b5501aa609082"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-toolchain-0.1+202501031114-1"
    sha256 arm64_sequoia: "1e1eda566b29d16b63ce7921d45b45d2db480d0ca9e6ddaf1d769b1d97ade3ba"
    sha256 arm64_sonoma:  "aaf6b1e9ba9f5e89085a696c884009ad684abdadd615ccbcc54747c851c936db"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "boost" => :build
  depends_on "bzip2" => :build
  depends_on "gawk" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "texinfo" => :build
  depends_on "expat"
  depends_on "flex"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "gnu-sed"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "ncurses"
  depends_on "xz"
  depends_on "zlib"
  depends_on "zstd"
  depends_on "readline" => :recommended

  def install
    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    gnu_mirror = "https://mirror.checkdomain.de/gnu"
    newlib_mirror = "https://ftp.gwdg.de/pub/linux/sources.redhat.com"
    system gmake + " -- prefix=#{prefix} GNU_MIRROR=#{gnu_mirror} NEWLIB_MIRROR=#{newlib_mirror}"
    system gmake + " install -- prefix=#{prefix}"
  end

  test do
    # no test for the time being
    system "true"
  end
end
