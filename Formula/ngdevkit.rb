class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202012090716.tar.gz"
  sha256 "05ed7bc4f66e0ed27762512266745bf1e3cf8b1f94a1a3a20bcc4310e67dbec4"
  version "0.2+202012090716-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "e928aab7e11a4185974725b06b978d8948aace67f020d28b954dca21c203d8f9" => :catalina
    sha256 "c30ca16456a85b6efa43c51e6fe6d13935e5bc954d613bcb7c90d3abf614efb7" => :mojave
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
