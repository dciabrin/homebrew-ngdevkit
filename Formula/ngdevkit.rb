class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202309062013.tar.gz"
  version "0.2+202309062013-1"
  sha256 "563869b05d357dce92df0d9c865005a325b1aaf8cf586030dbefbfedd6977ee5"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202309062013-1"
    sha256 cellar: :any_skip_relocation, monterey: "776d68ef3c3415e73402692d2776aaa1d1f1e1829f4786ae0f722933e1223feb"
    sha256 cellar: :any_skip_relocation, big_sur:  "7a07ea106bcc3245d2a354138fa596f277a2e5b40cbe862744bad01d89ea26e4"
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
