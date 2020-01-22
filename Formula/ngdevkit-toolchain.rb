class NgdevkitToolchain < Formula
  desc "ngdevkit toolchain"
  homepage "https://github.com/dciabrin/ngdevkit-toolchain"
  url "https://github.com/dciabrin/ngdevkit-toolchain/archive/nightly-20191223211107.tar.gz"
  sha256 "99d0c966f5810eda6a83d0f13ea650e89c412c74dd40a9fd409cf061f6c35c95"
  version "0.1+20191223211107-1"

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
    system $gmake, "--", "prefix=#{prefix}"
    system $gmake, "install", "--", "prefix=#{prefix}"
  end

  test do
    # no test for the time being
    system "true"
  end
end
