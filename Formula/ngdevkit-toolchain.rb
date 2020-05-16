class NgdevkitToolchain < Formula
  desc "ngdevkit toolchain"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-20191223211107.tar.gz"
  sha256 "99d0c966f5810eda6a83d0f13ea650e89c412c74dd40a9fd409cf061f6c35c95"
  version "0.1+20191223211107-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "8467d86c6b783a7a33fd9d761172862833f8bb80b76e42ec12bb2555f663de46" => :catalina
    sha256 "3388a6c6274bdc9375e99bf82099a5985e29f82288d49181e10de998415bc979" => :mojave
    sha256 "27b73d604d45694994110f3af373ee82336d0cb966c011ca53e4a86af5a4318a" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "flex" => :build
  depends_on "bison" => :build
  depends_on "gawk" => :build
  depends_on "gettext" => :build  
  depends_on "bzip2" => :build
  depends_on "xz" => :build
  depends_on "boost" => :build
  depends_on "expat" => :build
  depends_on "gmp" => :build
  depends_on "zlib" => :build
  depends_on "libmpc" => :build
  depends_on "mpfr" => :build
  depends_on "ncurses" => :build
  depends_on "readline" => :build
  depends_on "texinfo" => :build
  depends_on "pkg-config" => :build

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
