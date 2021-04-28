class NgdevkitToolchain < Formula
  desc "Toolchain for ngdevkit"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-202104282019.tar.gz"
  version "0.1+202104282019-1"
  sha256 "7cbc784793a8e8728cc3ccef7f48f54ab0308128c4809ab0bfeef4f1dbb6fded"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-toolchain-0.1+202104282019-1"
    sha256 catalina: "1aa35ae1f8c14f20b8fa3748303d37c8ed6c409a79ebb0131e280e11bc635246"
    sha256 mojave:   "4abef67907477eceb73f8304bed28639c3e766c31c61de21d3b48ec3f4532a4d"
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
  depends_on "readline" => :build
  depends_on "texinfo" => :build
  depends_on "expat"
  depends_on "flex"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "gnu-sed"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "ncurses"
  depends_on "xz"
  depends_on "zlib"

  def install
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    silent_flags = "-fno-show-source-location -fno-caret-diagnostics -fno-color-diagnostics "\
                   "-fno-elide-type -fno-diagnostics-fixit-info -Wno-array-bounds "\
                   "-Wno-unused-command-line-argument -Wno-implicit-function-declaration"
    ENV["CFLAGS"] = silent_flags
    ENV["CXXFLAGS"] = silent_flags
    ENV["CPPFLAGS"] = silent_flags
    # travis cut job when they are too verbose, so cut
    # the output drastically until we find a better
    # way to limit the compilation logs
    gnu_mirror = "https://mirror.checkdomain.de/gnu"
    newlib_mirror = "https://ftp.gwdg.de/pub/linux/sources.redhat.com"
    system gmake + " -- prefix=#{prefix} GNU_MIRROR=#{gnu_mirror} NEWLIB_MIRROR=#{newlib_mirror} |"\
                 + " awk '{printf \".\"; fflush()}'"
    system gmake + " install -- prefix=#{prefix}"
  end

  test do
    # no test for the time being
    system "true"
  end
end
