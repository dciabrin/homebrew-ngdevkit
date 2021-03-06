class NgdevkitToolchain < Formula
  desc "Toolchain for ngdevkit"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-202103061601.tar.gz"
  version "0.1+202103061601-1"
  sha256 "9a40979ad8ba190fb5e3dc76d641e69f3f176d5a969d455001359f039ff5dbd7"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 catalina: "5bef2fc705b74f93f83e03676da93ae89831f58f2eed917873b31674c15b0c9d"
    sha256 mojave:   "da99326786f58279696c5b621628afab02cfda48855ac41f1eeeab99fbf8df9e"
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
