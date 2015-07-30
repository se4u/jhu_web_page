require 'tempfile'

module Jekyll
  class PySVGTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @text = text
      @tokens = tokens
    end

    # Write the content between [pysvg , endpysvg] to a tmp file
    # Then run python on it. The output is whatever that python
    # code printed out.
    def render(context)
      file = Tempfile.new('')
      file.write(super)
      file.close   # close temp file; flush content
      output = `python #{file.path}`
      file.unlink  # Delete temp file
      "<figure><embed src=\"#{output}\" /></figure>"
    end
  end
end
Liquid::Template.register_tag('pysvg', Jekyll::PySVGTag)
