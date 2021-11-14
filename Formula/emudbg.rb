class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111140941.tar.gz"
  version "0.2+202111140941-1"
  sha256 "7710197725f5e68e70247e6a6fc34d368c7978984da8ec71291c9111d7aa67ea"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111140941-1"
    sha256 cellar: :any_skip_relocation, catalina: "8e208dffdb13609633f0c08f2a44fe1d88e3f250a97c30d0593b05244ad462a4"
    sha256 cellar: :any_skip_relocation, mojave:   "775085d6bc5ef74a3602ed3f49b165f8a968a31db0d4f9d0481a39894314bcbc"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake
    system gmake
    system gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
