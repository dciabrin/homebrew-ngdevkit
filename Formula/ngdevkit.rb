class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005191950.tar.gz"
  sha256 "27b44b82bbc6517144722a4e7c333521909e061cdda98e573a6023589c99102e"
  version "0.2+202005191950-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "10d4f8726410f0f79b7c9605d7d6d6913e4686e0d2df875152376e7fd3307e44" => :catalina
    sha256 "4f3bfd6625d318318102abcdb3693b71874d974b0517796772deabef50089ee3" => :mojave
    sha256 "5806c9e721c3cbdde8f5a89c534ecd70ae16321ba7a01d755c828baa1a4ec54b" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "python3"
  depends_on "ngdevkit-toolchain"
  depends_on "pkg-config"

  def install
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
           "--enable-external-toolchain",
           "--enable-external-emudbg",
           "--enable-external-gngeo",
           "--enable-examples=no"
    system $gmake
    system $gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
