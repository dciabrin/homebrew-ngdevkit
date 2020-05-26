class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005261926.tar.gz"
  sha256 "ab4e5c42fa105f143b36ed70e2543ecdce5fb60869392b77fc474c22621f29b6"
  version "0.2+202005261926-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "435cc57c7ce5ed315a154d77ba19e84b8b47a8b2af59a1414a71db748d51ec65" => :catalina
    sha256 "f6099ab1d8cce124c57eee1976a7b764d1e2e5306b6af5f7e099817d4b075199" => :mojave
    sha256 "05b22e02c742a24ebd757b8babac957ce03d9f9c1b71ee1b7342ddaf8c48ffa6" => :high_sierra
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
