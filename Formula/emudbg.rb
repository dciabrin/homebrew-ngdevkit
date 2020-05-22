class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202005221116.tar.gz"
  sha256 "50826afeca7d314efa12a1f5d7971a4d528bde1b5f9d5d9755799e7126fa2d42"
  version "0.2+202005221116-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "313518069e8acc5733e08fcf11c81a5cf4cd4c67f8098ed89f3fb83108efc06c" => :catalina
    sha256 "4d59910bab50e2ae04eebc59efbde94d7256a9c44c1b1785f210d9e5888169de" => :mojave
    sha256 "70891216593ec82803e10389d1546c15401f4081614062d2983241b755d82aec" => :high_sierra
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
