class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005291957.tar.gz"
  sha256 "148e9ad9a68b41bf06431f53e3e779b12d8e7dc5e641c7be4d5932d0a3005ef5"
  version "0.2+202005291957-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "833f3bebe265c413bfb1356e499ff4adf56db56e9b26707c37136bd594fe925d" => :catalina
    sha256 "e8e492858815c5fb3359ebff09c61d3066b0a525eb660280349fc7570bbf3bf8" => :mojave
    sha256 "9225590a901b1010156a247006b237c2dfdcb9e24dc2bbf850795df45d9efe60" => :high_sierra
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
