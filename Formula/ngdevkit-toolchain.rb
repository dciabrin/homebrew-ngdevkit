class NgdevkitToolchain < Formula
  desc "Toolchain for ngdevkit"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-202302220848.tar.gz"
  version "0.1+202302220848-1"
  sha256 "099ca0d46683772a28f838517e56338d4945915126d2e4233ab449fba09b401d"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-toolchain-0.1+202302220848-1"
    sha256 monterey: "64099505871432ac03941d0cee7790ebf00918c9809aae81ff3f7237068c6fce"
    sha256 big_sur:  "71d16e8eabab4dce305882c612cc6c62fe285169cf86b5b89337fb6e4c0e565e"
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
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "ncurses"
  depends_on "xz"
  depends_on "zlib"
  depends_on "readline" => :recommended

  def install
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    silent_flags = "-fno-show-source-location -fno-caret-diagnostics -fno-color-diagnostics " \
                   "-fno-elide-type -fno-diagnostics-fixit-info -Wno-array-bounds " \
                   "-Wno-unused-command-line-argument -Wno-implicit-function-declaration"
    ENV["CFLAGS"] = silent_flags
    ENV["CXXFLAGS"] = silent_flags
    ENV["CPPFLAGS"] = silent_flags
    # travis cut job when they are too verbose, so cut
    # the output drastically until we find a better
    # way to limit the compilation logs
    gnu_mirror = "https://mirror.checkdomain.de/gnu"
    newlib_mirror = "https://ftp.gwdg.de/pub/linux/sources.redhat.com"
    system gmake + " -- prefix=#{prefix} GNU_MIRROR=#{gnu_mirror} NEWLIB_MIRROR=#{newlib_mirror} |" \
                 + " awk '{printf \".\"; fflush()}'"
    system gmake + " install -- prefix=#{prefix}"
  end

  test do
    # no test for the time being
    system "true"
  end
end
