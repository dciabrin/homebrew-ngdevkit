class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202005291941.tar.gz"
  sha256 "4679d361c91ce250de00ce567861c60bdfda3f8521376f5b0843dcafa4660457"
  version "0.8.1+202005291941-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "34791970d7a632ab0e596cc0c300874dada631b63fc66c276efcb10550f22e3d" => :catalina
    sha256 "933ed084d1bdbc20d3d577f0a7cea3fb3d8578bd2ee757f6ce804a5a8aff764e" => :mojave
    sha256 "20c7a482a8b5485be5e583bd6919b4169bf3663bcf705a6ef9933ec1de78cf92" => :high_sierra
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
