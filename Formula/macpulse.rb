class Macpulse < Formula
  include Language::Python::Virtualenv

  desc "Tells you why your Mac was slow this week and what to do about it"
  homepage "https://github.com/anirudhjayaraman/macpulse"
  url "https://github.com/anirudhjayaraman/macpulse/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a2a15f76dda647c4d2f6f436154f2b2fe9332928c48e3bbc48d7dcbfec32f746"
  license "MIT"

  depends_on :macos
  depends_on "python@3.14"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Finish setting up (background recording and alerts) with:
        macpulse setup

      Before `brew uninstall macpulse`, run:
        macpulse uninstall
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/macpulse --version")
    ENV["MACPULSE_HOME"] = testpath
    system bin/"macpulse", "check", "--json", "--interval", "0.1"
  end
end
