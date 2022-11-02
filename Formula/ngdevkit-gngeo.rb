class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202211021152.tar.gz"
  version "0.8.1+202211021152-1"
  sha256 "f79643a3044ac7eec0ad9d7aae8d813c8fe274cb5bdceaa768e3bd79a16a628c"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-gngeo-0.8.1+202211021152-1"
    sha256 monterey: "f85f69fe63889d58d47576ed4b95da207e28648a770fd423160012f646628667"
    sha256 big_sur:  "5e83e124bea25b9b8f3c0f4e72440f2302828d4bf155740ae517bb05b638503b"
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
                          "--program-prefix=ngdevkit-",
                          "CFLAGS=-Wno-implicit-function-declaration -DGNGEORC=\\\\\"ngdevkit-gngeorc\\\\\""
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
