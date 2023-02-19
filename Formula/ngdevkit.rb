class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202302191925.tar.gz"
  version "0.2+202302191925-1"
  sha256 "a46009ff73f3a741f2ee32dcd991ad089e7015e5c6ada0b2f63854b6396f7f00"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202302191925-1"
    sha256 cellar: :any_skip_relocation, monterey: "6d7c810f943dafeeb4acadfd0ce9b8b8e093c4c18e3e88a8d1fca6b1137860ad"
    sha256 cellar: :any_skip_relocation, big_sur:  "e6977944869c974f055c2f8cd65bd1a34275d3dde410d263f7aad9742825ba77"
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
