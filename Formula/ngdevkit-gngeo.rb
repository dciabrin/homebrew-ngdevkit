class NgdevkitGngeo < Formula
  desc "Portable Neo-Geo emulator customized for ngdevkit"
  homepage "https://github.com/dciabrin/gngeo"
  url "https://github.com/dciabrin/gngeo/archive/nightly-202005230600.tar.gz"
  sha256 "7629262140e9ad627a3600951fdde5b69d3be12c445ae1fa983238faa7f7facb"
  version "0.8.1+202005230600-1"

  bottle do
    root_url "https://dl.bintray.com/dciabrin/bottles-ngdevkit"
    sha256 "957cb76936d36bc0e37f3afd606c9360cf9b767576f97516dea6a0ac1d4634bd" => :catalina
    sha256 "685db81a5a2f26c595cc981b983175b7c842c8ac1fe7021797046aad6e164774" => :mojave
    sha256 "8b3b5312cba54177dbeaad0eafa456cb9385e7d03bf82a5b15a38636043d3768" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "glew"
  depends_on "sdl2"

  def install
    ENV.deparallelize
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
                          "--program-prefix=ngdevkit-"
    $gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = $gmake
    system $gmake, "-j1", "pkgdatadir=#{prefix}/share/ngdevkit-gngeo"
    system $gmake, "install", "pkgdatadir=#{prefix}/share/ngdevkit-gngeo"
  end

  test do
    # no test for the time being
    system "true"
  end
end
