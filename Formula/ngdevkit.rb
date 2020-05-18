class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005181936.tar.gz"
  sha256 "cfa2133b7f9316e03dbfe58d526a238edb25de9f344786dd8eaa30fd4efacb75"
  version "0.2+202005181936-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "074f45c4896e2257754c2b3d6da2702bca8a53e53a81cc92900d1b5c70a31abd" => :catalina
    sha256 "afa12c3208a8143dea41b822b77504ac1acdfe419650822d0910ac779c92ee66" => :mojave
    sha256 "1fa6f7cf61b9cba81d724692ba8f2abea9bce39bb391ce3ecefd7aee19074416" => :high_sierra
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
