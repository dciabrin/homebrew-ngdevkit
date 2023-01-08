class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202212301452.tar.gz"
  version "0.2+202212301452-2"
  sha256 "0c52639be5276931b9f3f6ccc98b229606947d21fe50cde06e4c1740a74427e1"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202212301452-2"
    sha256 cellar: :any_skip_relocation, monterey: "6bd1f27f1439d2e4536ed5f92e30cb45390216f454c41631e949dce21b6a4098"
    sha256 cellar: :any_skip_relocation, big_sur:  "ce14a4467879185f0ed013abc551e9e28b42f77e6f3cb73c4b75842fc6d69801"
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
