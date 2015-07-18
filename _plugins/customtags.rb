module Jekyll
  class CenterText < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
      @tag_name = tag_name
      @tokens = tokens
    end

    def render(context)
      ["#{@text}", "{: style=\"text-align: center;\"}"].join("\n")
    end
  end

  class KramdownInclude < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end
    require "kramdown"
    def render(context)
      tmpl = File.read File.join Dir.pwd, "_includes", @text
      site = context.registers[:site]
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload
      html = Kramdown::Document.new(tmpl).to_html
    end
  end
end

Liquid::Template.register_tag('center_text', Jekyll::CenterText)
Liquid::Template.register_tag('kramdown_include', Jekyll::KramdownInclude)
