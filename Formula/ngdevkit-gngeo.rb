class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202102262205.tar.gz"
  version "0.8.1+202102262205-1"
  sha256 "50c14385b335d456f73c0519349522652a6fdd04a946bee0bc6a882f116eb827"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 catalina: "1ef4d082c105cbd09ce48f79f71a951390d5182d89c51221ebd22b444d741f89"
    sha256 mojave:   "fa6a548d84a4a2d998ddf7a5d82a891dcc8196b10f1a19710b29db42bda0b00d"
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
