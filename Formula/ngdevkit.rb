class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202005301056.tar.gz"
  sha256 "570bdfa3a2387f0f3001c55e7325086daadd7da2033a93a5c794b4ddacf3c148"
  version "0.2+202005301056-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "cc75bab392e681cadf1b6acad17961e841b45254d513f4f6f9e6ef9ba07d7112" => :catalina
    sha256 "bdc06947a998a2b3403f7ae86e61ff9a082a854ed506086f0de3d5b6fb8a9fcb" => :mojave
    sha256 "db4416850e4edfbe1ef2aa46396aea770b8a401bd57a5b0ce16c2968fc65193b" => :high_sierra
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
