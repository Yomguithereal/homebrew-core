class Slackdump < Formula
  desc "Export Slack data without admin privileges"
  homepage "https://github.com/rusq/slackdump"
  url "https://github.com/rusq/slackdump/archive/refs/tags/v3.0.8.tar.gz"
  sha256 "4357df862912b890bb53826bc0c4c3dd61daadabec1fde56b88ad7a2ac31de43"
  license "GPL-3.0-only"
  head "https://github.com/rusq/slackdump.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "34ecfb5ee1c0072cef53813d5ae1094a43ff851ee8784af77f4c6712ea054df3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "34ecfb5ee1c0072cef53813d5ae1094a43ff851ee8784af77f4c6712ea054df3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "34ecfb5ee1c0072cef53813d5ae1094a43ff851ee8784af77f4c6712ea054df3"
    sha256 cellar: :any_skip_relocation, sonoma:        "87bba95573ce8cb21b32d045cd68e6ca498a2156a8e0e3bd67da3bea4889c0cc"
    sha256 cellar: :any_skip_relocation, ventura:       "87bba95573ce8cb21b32d045cd68e6ca498a2156a8e0e3bd67da3bea4889c0cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07388d163a8eb81460e38e38a69852764f78e72acad9ffc614fe873b50207e7e"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.date=#{time.iso8601}
      -X main.commit=Homebrew
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/slackdump"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slackdump version")

    output = shell_output("#{bin}/slackdump workspace list 2>&1", 9)
    assert_match "ERROR 009 (User Error): no authenticated workspaces", output
  end
end
