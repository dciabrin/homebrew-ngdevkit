class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005160904.tar.gz"
  sha256 "d8f840bbef80350c2f0a6327d67b349726c304200f714ee14781fe24c681dc14"
  version "0.2+202005160904-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "04bf937affcd1a07b2d1a0d9a967fae3ef9bbdaa9f95dbd1f5fa097560e96763" => :catalina
    sha256 "25f214d44afc307a90ccb5e900df5b45c13bc8b9919b748cd8bd8cd8df7eecf1" => :mojave
    sha256 "808c7cb8a1bc1e94d7a3db4beaaa2ffef76c86c71b22b3ce4711b941f046f4b9" => :high_sierra
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
