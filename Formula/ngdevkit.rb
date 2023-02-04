class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202212301452.tar.gz"
  version "0.2+202212301452-5"
  sha256 "0c52639be5276931b9f3f6ccc98b229606947d21fe50cde06e4c1740a74427e1"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202212301452-5"
    sha256 cellar: :any_skip_relocation, monterey: "b5b33e0685c4a79d0adfa894f95b930d3d5d8b18f51e49a90361f26ed907e5af"
    sha256 cellar: :any_skip_relocation, big_sur:  "a810d6b51ec9d35adfa6138ebaec7d6ce01db9d1e4dcaf944d84703bf1c1b9da"
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
