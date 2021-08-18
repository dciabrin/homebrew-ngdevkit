class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202108161748.tar.gz"
  version "0.2+202108161748-1"
  sha256 "6652f1309cf7eb1a1e36be35dd80710a935bf338df9bbb5ed73e4de56a36bdea"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202108161748-1"
    sha256 cellar: :any_skip_relocation, catalina: "eb9306c9ca37a753ed8d992bb93fbc2a700449685668bda5b0438c2f570d5cbb"
    sha256 cellar: :any_skip_relocation, mojave:   "aea6f161b32ef07f7c86c413c8d0be05e4fb98ea78c1e32d2a5cc1d5285eea91"
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
