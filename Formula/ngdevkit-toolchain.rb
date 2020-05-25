class NgdevkitToolchain < Formula
  desc "ngdevkit toolchain"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-202005251226.tar.gz"
  sha256 "11cc4b2cd1b98409580657e71c781622b174280ef9b883fdd90f58d87410214d"
  version "0.1+202005251226-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "558c0c4af7871f036242d14f21932a95ba3726b95254ab8c8136e8b054454c72" => :catalina
    sha256 "da53b7b656fbefb342de92471bf808a5c1b3aa6a155538ccd0114d0a8f598f6c" => :mojave
    sha256 "69de9cf8d9c2aebde6f8b02cb9d95fb4fefaaab663c7ed89d76ad647f6161b51" => :high_sierra
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
