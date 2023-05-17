class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202305170917.tar.gz"
  version "0.2+202305170917-1"
  sha256 "64cccb2eaf2760742b0381c606555322ad30b22745fe9f4584548d3eba65bb4a"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202305170917-1"
    sha256 cellar: :any_skip_relocation, monterey: "b96db1699f8372109ea2f670120dcf5332646e9c98acf41252e186bb645a6ba5"
    sha256 cellar: :any_skip_relocation, big_sur:  "a65ee3bf50e8a55437f931fbb9f39939c06b0e3ffa492f5fa10afe586882720a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "ngdevkit-toolchain"
  depends_on "pkg-config"
  depends_on "python3"

  def install
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
           "--enable-external-toolchain",
           "--enable-external-emudbg",
           "--enable-external-gngeo",
           "--enable-examples=no"
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
