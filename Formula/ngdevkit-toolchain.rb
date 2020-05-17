class NgdevkitToolchain < Formula
  desc "ngdevkit toolchain"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-20191223211107.tar.gz"
  sha256 "99d0c966f5810eda6a83d0f13ea650e89c412c74dd40a9fd409cf061f6c35c95"
  version "0.1+20191223211107-3"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "b37166c825a5971921dcc36af0eaa81c262a8e88b3a06fc260a63161c1775836" => :catalina
    sha256 "cacd2338950c491d0d21d45e3fc3d95320b8deaf93e597385fff28b2cffb0c6e" => :mojave
    sha256 "4041d963efb92c18241869ff69a6f7e6211f9ba2073c7feecfed02bef08afa18" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "bison" => :build
  depends_on "gawk" => :build
  depends_on "bzip2" => :build
  depends_on "boost" => :build
  depends_on "readline" => :build
  depends_on "texinfo" => :build
  depends_on "pkg-config" => :build
  depends_on "expat"
  depends_on "flex"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "ncurses"
  depends_on "libmpc"
  depends_on "xz"
  depends_on "zlib"

  def install
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    $silent_flags = "-fno-show-source-location -fno-caret-diagnostics -fno-color-diagnostics -fno-elide-type -fno-diagnostics-fixit-info -Wno-array-bounds -Wno-unused-command-line-argument"
    ENV["CFLAGS"] = $silent_flags
    ENV["CXXFLAGS"] = $silent_flags
    ENV["CPPFLAGS"] = $silent_flags
    # travis cut job when they are too verbose, so cut
    # the output drastically until we find a better
    # way to limit the compilation logs
    system $gmake + " -- prefix=#{prefix} | awk '{printf \".\"; fflush()}'"
    system $gmake + " install -- prefix=#{prefix}"
  end

  test do
    # no test for the time being
    system "true"
  end
end
