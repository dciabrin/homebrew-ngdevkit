class Ngdevkit < Formula
  include Language::Python::Virtualenv

  desc "Open source development for Neo-Geo"
  homepage "https://github.com/dciabrin/ngdevkit"
  url "https://github.com/dciabrin/ngdevkit/archive/refs/tags/nightly-202603131705.tar.gz"
  version "0.4+202603131705-2"
  sha256 "aac8bcbf37de2e125f42f8a6fd706152192395f6dfe42cdecc34042550abf199"

  bottle do
    root_url "https://github.com/dciabrin/homebrew-ngdevkit/releases/download/ngdevkit-0.4+202603131705-2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aee021cfea5c360dd1c178ef5d74e0bf1dcae44460e55bf6ee6102b6010e4a96"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "65863bd9d5338dfabe6d1963328f06f3b8ab4bfaff309cfc80bfff7ae9fb2957"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "m4" => :build
  depends_on "make" => :build
  depends_on "zip" => :build
  depends_on "ngdevkit-toolchain"
  depends_on "pillow"
  depends_on "pkg-config"
  depends_on "python@3.14"

  resource "ruamel-yaml" do
    url "https://files.pythonhosted.org/packages/c7/3b/ebda527b56beb90cb7652cb1c7e4f91f48649fbcd8d2eb2fb6e77cd3329b/ruamel_yaml-0.19.1.tar.gz"
    sha256 "53eb66cd27849eff968ebf8f0bf61f46cdac2da1d1f3576dd4ccee9b25c31993"
  end

  def install
    # Some python dependencies are not available as brew packages, so we
    # install them via pip in a dedicated venv, which will land in libexec.
    # The original ngdevkit file wills land in /usr/lib, except the python
    # scripts (and stuff from exec-prefix), which also land in libexec.
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resource("ruamel-yaml")

    # We require gnu make > 4.0, so use the one from brew
    gmake = "#{Formula["make"].opt_bin}/gmake"
    ENV["MAKE"] = gmake

    # Homebrew picks the system's gnu M4, which is too old for autoreconf
    # (it doesn't have option --gnu). Pick homebrew's version instead
    ENV["M4"] = "#{Formula["m4"].opt_bin}/m4"

    # For M1 macs, brew libraries are installed in a non-standard
    # location, so some env vars must be set for autotools
    # ACLOCAL_PATH and PKG_CONFIG_PATH are set by brew
    ENV["CFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CXXFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["CPPFLAGS"] = "-I#{HOMEBREW_PREFIX}/include"
    ENV["LDFLAGS"] = "-L#{HOMEBREW_PREFIX}/lib -Wl,-rpath,#{HOMEBREW_PREFIX}/lib"

    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}",
           "--enable-external-toolchain",
           "--enable-external-emudbg",
           "--enable-external-gngeo",
           "--enable-examples=no"
    system gmake
    system gmake, "install"

    # Lastly, let brew generate stubs for all the python scripts in ngdevkit.
    # Those stubs set up PYTHONPATH and run the real scripts automatically.
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python3.14/site-packages"
    bin.install Dir[libexec/"bin/*.py"]
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    # no test for the time being
    system "true"
  end
end
