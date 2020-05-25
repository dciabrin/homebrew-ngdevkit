class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005250010.tar.gz"
  sha256 "7fa94885aa7e1d07d6775c20090336ab4205a26d3a820b7d9737f1f0ecaa9c3b"
  version "0.2+202005250010-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "077ad3cac31f9840e3cfb6ce1e5f8a66fec988efd997403ea703a5b7f86c7e98" => :catalina
    sha256 "56dfb31130b0d618fd02bde8963cee11cfe431fa1924aa9b8fbc5e0559297e9e" => :mojave
    sha256 "32761c0028dad85e16cd4764aeb08f3e6f8ca95c26a9f3fa9fa854cd5e0a6faf" => :high_sierra
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
