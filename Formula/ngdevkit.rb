class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202302181140.tar.gz"
  version "0.2+202302181140-1"
  sha256 "0da294ecb9d044713145c0e247c147df761a6e3b69c13f111dd3bcf922abaa22"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202302181140-1"
    sha256 cellar: :any_skip_relocation, monterey: "b3c43866ab4c9f5e1ab6f9524d2f143be5680ae753d9785ddfd35dcb8e2b89b4"
    sha256 cellar: :any_skip_relocation, big_sur:  "b73b379be258483b55b55ea601fca487470bf8bf9f8c0fb75a3ba58b44edd480"
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
