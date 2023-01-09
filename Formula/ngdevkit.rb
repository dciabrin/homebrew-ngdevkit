class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202212301452.tar.gz"
  version "0.2+202212301452-3"
  sha256 "0c52639be5276931b9f3f6ccc98b229606947d21fe50cde06e4c1740a74427e1"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202212301452-3"
    sha256 cellar: :any_skip_relocation, monterey: "9b291a2da3abf58b8a4ce710ca2b72e63b06c1419ca8a337ed109cb9f11c5af5"
    sha256 cellar: :any_skip_relocation, big_sur:  "361c668043b3012e0db8b11c96c46f9c28b34b9e791e121d3c500a641640329c"
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
