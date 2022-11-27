class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202211271221.tar.gz"
  version "0.2+202211271221-1"
  sha256 "70610624db11002845ced60b8ca6316f692fab86fa7c760823a583a050923df4"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202211271221-1"
    sha256 cellar: :any_skip_relocation, monterey: "e07d35bfa7e2210322194653550093b494c9dcb2027b667360c8e1e8db9773d3"
    sha256 cellar: :any_skip_relocation, big_sur:  "68d9e13f6495b797610ccbcad51e7fd8990fedde939ae5ec8a012d252ba03223"
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
