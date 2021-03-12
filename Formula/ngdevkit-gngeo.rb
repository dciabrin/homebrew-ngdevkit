class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202103121947.tar.gz"
  version "0.8.1+202103121947-1"
  sha256 "f1de8c3effe8d8b4e7f9b05e707e49eb98f457fab5dd14b3b3046a87d827aabe"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 catalina: "5c000f3f69b90e08327244ba6f798ac20808deb14071b08fa9b63ceef3bde50e"
    sha256 mojave:   "8e5a175a08d2ef0789bb9a7f91f98c97aa90c1a6a8c492170cd90090c650c8d1"
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
