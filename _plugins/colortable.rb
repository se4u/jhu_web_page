module Jekyll
  class ColoredTableTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @text = text
      @tokens = tokens
    end

    # Render the content between [colortable , endcolortable] as an html table
    # The first line maps a symbol to a color
    # The rest of the lines are a symbol x symbol table.
    def render(context)
      # super is the input
      file = Tempfile.new('')
      file.write(super)
      file.close   # close temp file; flush content
      output = `/Users/pushpendrerastogi/Dropbox/se4u_github_io/_plugins/org2html.py #{file.path}`
      file.unlink  # Delete temp file
      output
    end
  end
end
Liquid::Template.register_tag('colortable', Jekyll::ColoredTableTag)
