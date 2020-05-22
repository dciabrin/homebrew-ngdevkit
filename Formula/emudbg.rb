class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202005221028.tar.gz"
  sha256 "baf2a506ae3a79a21312311e1f94f4debb9dc35a7c4e3606aa443a137ab429f0"
  version "0.2+202005221028-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "e4438fc223827538f2b197492c6bb9e51b3a0ebb442a9a0c27180a868141b52f" => :catalina
    sha256 "e19acdd35a96dc94025af5b7fa354d99373228e4350a090ecbfeac33fa46c6d9" => :mojave
    sha256 "39f050ebbe4c32ac50e8aea07f2e37b8b934f58c1e751b46b3e50042461f426a" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkgconfig"

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system $gmake
    system $gmake, "install"
  end

  test do
    # no test for the time being
    system "true"
  end
end
