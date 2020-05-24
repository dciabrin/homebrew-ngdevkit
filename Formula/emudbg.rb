class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202005241711.tar.gz"
  sha256 "7b27a999e07f775a9935ec096a553094aaaf082039363d9bbdeab7abb1772354"
  version "0.2+202005241711-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "fc0cefbf81747bf1ba91a23387794c8dbfaf3344dc6988af1f60eca4fdd1f213" => :catalina
    sha256 "95f11aa36bb8681abdbebda1cab8c8251e0b04e739d25871f35da630019046e0" => :mojave
    sha256 "c8461a1b1309c0571305182bdbf2662bfd2693dadc9a3b0febf2d1aa52bdb8fd" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system $gmake
    system $gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
