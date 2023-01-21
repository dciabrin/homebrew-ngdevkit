class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111141535.tar.gz"
  version "0.2+202111141535-4"
  sha256 "5ac567efdca679dc46854581d87ab6f9b88fc920adbd1896cdb32c1dd233a443"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111141535-4"
    sha256 cellar: :any_skip_relocation, monterey: "1806b9d9e7e10952aef31d81d903ff3887e7d99a4d335017a06ee4521b4e919e"
    sha256 cellar: :any_skip_relocation, big_sur:  "3c42840793264d1023314bba57fc10454876ba6b2a5627953351385df1e38abf"
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
