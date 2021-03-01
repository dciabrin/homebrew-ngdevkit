class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202103011435.tar.gz"
  version "0.2+202103011435-1"
  sha256 "82649a274f5e9c57a30e33b06ac18485c8f1ab6aebc02ccd631ed73ab80962cd"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 cellar: :any_skip_relocation, catalina: "eacfcf2567eab70409744a9c194e3be9e94e47ec6b629ae1bcea76af969d0185"
    sha256 cellar: :any_skip_relocation, mojave:   "aaf380832754f2ea29a7399e446c8b47a385ff05abdb9e60d4eba9442f4a9715"
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
