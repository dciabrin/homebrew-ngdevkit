class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202212301452.tar.gz"
  version "0.2+202212301452-1"
  sha256 "0c52639be5276931b9f3f6ccc98b229606947d21fe50cde06e4c1740a74427e1"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202212301452-1"
    sha256 cellar: :any_skip_relocation, monterey: "2221d3c2505c3028c13b74233feb86960bf2161553dc0d9ffe6565cfd91060c8"
    sha256 cellar: :any_skip_relocation, big_sur:  "0dd1ee443ab1876f015d05e34b6ac8c02c3650cb8ccbe2973a773c58ee08ed41"
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
