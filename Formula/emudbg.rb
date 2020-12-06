class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202012062246.tar.gz"
  sha256 "77744361d113a34b94b1ca98c320055ab3a23a512bd43e24ab1197c82630e896"
  version "0.2+202012062246-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "8ab0aceeb07dae1a74961c4e1060e0179002af3e5eb8cf52ec2e3ae7282dbf95" => :catalina
    sha256 "b9e3099491aa3d3f2ecca3a8325a4dff4ef09587f29556baae8bb776f789a67f" => :mojave
    sha256 "69dc331a7e660f91582312c180585f18d098bf9c22758396d27002a843cc3565" => :high_sierra
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
