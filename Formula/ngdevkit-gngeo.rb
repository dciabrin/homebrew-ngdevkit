class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202302191800.tar.gz"
  version "0.8.1+202302191800-1"
  sha256 "19020744682c1d81d06034eb383236ea5bebc99db08ce79c99746b0a6b734383"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-gngeo-0.8.1+202302191800-1"
    sha256 monterey: "89c953f3d91a6a23b37f4746398190d3962a708bd172674a58d72830c7e9557d"
    sha256 big_sur:  "3620ed396a32440e26caa3fb73c757033c6eb0ee0afc82129392da649b6219c1"
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
