class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202103122225.tar.gz"
  version "0.8.1+202103122225-1"
  sha256 "773135c17a51961809d887410d74718892fdbc033744b27909e0f9cd15fbaebe"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 catalina: "39e89ce658acd9b888a839f53d79c46f2e25e57abd5b5b9a5595cd270760b229"
    sha256 mojave:   "6d9b108bd090f8d5561a93c1d75bbc815bde25d99fe5ee1d92373e28816b5aa0"
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
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    system gmake, "-j1", "pkgdatadir=#{share}/ngdevkit-gngeo"
    system gmake, "install", "pkgdatadir=#{share}/ngdevkit-gngeo"
  end

  test do
    # no test for the time being
    system "true"
  end
end
