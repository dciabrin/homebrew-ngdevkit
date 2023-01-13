class Emudbg < Formula
  desc "Emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202111141535.tar.gz"
  version "0.2+202111141535-3"
  sha256 "5ac567efdca679dc46854581d87ab6f9b88fc920adbd1896cdb32c1dd233a443"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/emudbg-0.2+202111141535-3"
    sha256 cellar: :any_skip_relocation, monterey: "8bd6f02fab3f0901c53ad5941fe5c9ba27a11e0ee5e65ae79312d22b9a563609"
    sha256 cellar: :any_skip_relocation, big_sur:  "a526c7330f0f0c6b237ed3704bd81780987ae6df81091ffad54bc0300361f3f3"
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
