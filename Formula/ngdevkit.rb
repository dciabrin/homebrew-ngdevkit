class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005262132.tar.gz"
  sha256 "2d1addf08b156a0e166069164ce3eb378a0570046986f79145e544002591dea5"
  version "0.2+202005262132-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "427818ffba2c3e5559c2cc5f782cb792d10ca66b9faa9068b9af2e7023b3d024" => :catalina
    sha256 "a8e9cb4b30a5030de70397264c6de5353962f45fc2b724daac346ce4a009a74a" => :mojave
    sha256 "d8f39ea9f3eeedb6e7fa3829e09c236b6053dab4514afcaa079a64f93397364d" => :high_sierra
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
