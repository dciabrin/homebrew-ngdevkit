class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202006101934.tar.gz"
  sha256 "9cccde888206d60a147728b07297939e3bfc133cbe8b221c8fb5555045911d12"
  version "0.8.1+202006101934-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "dbcdb80d44174900a65e981a86d9d97a4582308a129bdc444cd768520d561550" => :catalina
    sha256 "28b2e3c838e39e6c04ee679a0d29ed01988d562002e1444511c9199fdadd691e" => :mojave
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
