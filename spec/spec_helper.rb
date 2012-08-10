require 'cover_me'
require File.expand_path('../../lib/checkers', __FILE__)

CoverMe.config do |c|
  c.project.root = File.expand_path('../../', __FILE__)
  c.html_formatter.output_path = File.expand_path('../coverage', __FILE__)
  c.file_pattern =
    /(#{CoverMe.config.project.root}\/lib\/.+\.rb)/i

  c.at_exit = Proc.new {
    if CoverMe.config.formatter == CoverMe::HtmlFormatter
      index = File.join(CoverMe.config.html_formatter.output_path, 'index.html')
    end
  }
end
