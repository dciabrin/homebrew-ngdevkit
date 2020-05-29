class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202005292104.tar.gz"
  sha256 "a14ebdfbeda2ff7a41b8bcb0a9afbf34693a0fc5e679408b0696a8fa47bb25bb"
  version "0.8.1+202005292104-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "c2168f9b8c9bf2b2425473aed99f16b6c5e86d62db747b98c9c6881bde77b699" => :catalina
    sha256 "a962c213518db180ad2e8f1a34b70fd84e800dae487ca9d84c332f4d9266d313" => :mojave
    sha256 "73ec8ee11725edaf68a72149bbe0f54866c1f79b0841131a12ec52c0d94be9fa" => :high_sierra
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
