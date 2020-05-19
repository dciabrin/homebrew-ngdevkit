class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-20200119170941.tar.gz"
  sha256 "2f2674bb84c6cddaeedb785964e7130298c3f76ef85cfb5e0f5e8ff39f8e8ea0"
  version "0.8.1+20200119170941-2"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "a753caed9ef708ddad0451243704af21d8b74b431a2ca045a77c52ad02a27b68" => :catalina
    sha256 "18a39654d54f26a2e9291364c511bc032964d79b0cfb1310ddfa3aafaf971162" => :mojave
    sha256 "b93dfae458e1c1be37d6352467bf4e7afdbc5197983bb79126c2330ea38eb349" => :high_sierra
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
