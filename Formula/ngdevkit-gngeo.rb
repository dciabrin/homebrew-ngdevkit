class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202005281734.tar.gz"
  sha256 "1bf1d5b7988fe0622f9dcb24478375a708159050f3cc1cacbe112b7b53c75db8"
  version "0.8.1+202005281734-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "bbea0a4f5e44acb5ae66b34546419fa867876c2094d4524e9a6471a8e0559e98" => :catalina
    sha256 "c70de177353ccd0aec40136ca6e20be1700b075889809b3c2d88aa9600d584ae" => :mojave
    sha256 "e6ab55523823ee66db4329661e419a6245a73554ea7c26618349c6cf5555204c" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "glew"
  depends_on "sdl2"

  def install
    ENV.deparallelize
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
                          "--program-prefix=ngdevkit-"
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system $gmake, "-j1", "pkgdatadir=#{prefix}/share/ngdevkit-gngeo"
    system $gmake, "install", "pkgdatadir=#{prefix}/share/ngdevkit-gngeo"
  end

  test do
    # no test for the time being
    system "true"
  end
end
