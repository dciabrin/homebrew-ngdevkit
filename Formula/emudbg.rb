class Emudbg < Formula
  desc "emulator-agnostic source-level debugging API"
  homepage "https://github.com/dciabrin/emudbg"
  url "https://github.com/dciabrin/emudbg/archive/nightly-202005292051.tar.gz"
  sha256 "03a2fe2cef0553cfbc1f472f1bde6179acec03d78253551a0cbc572e5b2fc5d1"
  version "0.2+202005292051-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    cellar :any_skip_relocation
    sha256 "feeb273918c2007d7953815f0f023ccb3ebb12b86d55540260145049b6969562" => :catalina
    sha256 "b57b2064150869dbfebab442fd63280713877ddc165b238b5471abcb4f2cb6af" => :mojave
    sha256 "7e28bfd1a8a610d4751af11ad52549be65624f0a833b7711404bbc67da2e28a5" => :high_sierra
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
