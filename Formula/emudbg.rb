class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202006101942.tar.gz"
  sha256 "a7eacf2720c4dad1c4dadae99632260666c03acbd59c785c28f8dd5590cdbd99"
  version "0.2+202006101942-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "eb679df40453992fd213c4da8f3ec5ef8bd2c509ebd7943293813e3e6fe63f2e" => :catalina
    sha256 "7a24dc23e363bbafc36ce32163543f0f73731fe416996262071a4c81767706e6" => :mojave
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
