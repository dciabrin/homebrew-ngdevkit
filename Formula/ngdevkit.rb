class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202103031636.tar.gz"
  version "0.2+202103031636-1"
  sha256 "5d3f4d2ca06fc9d529b88fb7c9256ec845dcd4b191e59ffda9f0cc3259fc00e6"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 cellar: :any_skip_relocation, catalina: "929803db0e58742dd9106d79b82501831f34080362b9a6638c4b48d65fc85cb4"
    sha256 cellar: :any_skip_relocation, mojave:   "b127f654c2c1cd8d948d9e9c98912d92f4a920a739436d98e45ca528c1b002ab"
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
