class NgdevkitToolchain < Formula
  desc "Toolchain for ngdevkit"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/refs/tags/nightly-202606181616.tar.gz"
  version "0.1+202606181616-1"
  sha256 "ab03b8e6d45532fc302cbfeb5d50059ee8d1c576685047652f5f14c71d31ee4e"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-toolchain-0.1+202606181616-1"
    sha256 arm64_sequoia: "6a025adcd034744657f8513abff24657770cb94a3ea8cb8d03698cf77c67e844"
    sha256 arm64_sonoma:  "c7a0e0852449e830128f1a7162ef94735cdda7155cb7524fbbf18f49fe663de3"
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
  depends_on "readline"
  depends_on "xz"
  depends_on "zstd"

  uses_from_macos "zlib"

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
