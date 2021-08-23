class Ngdevkit < Formula
  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/nightly-202108231901.tar.gz"
  version "0.2+202108231901-1"
  sha256 "b29db9598745e9749804b1d513273d907c9e73f44762828b62d53443663c1f4d"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.2+202108231901-1"
    sha256 cellar: :any_skip_relocation, catalina: "640e11e6bed82a9264f67d0df8d894efa5dccd8b8fd16c7406c21f620a834ef6"
    sha256 cellar: :any_skip_relocation, mojave:   "352e4ee81cea7afbdb8aaee1b2a18d6b266ef59607509433553ce4c50182e455"
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
