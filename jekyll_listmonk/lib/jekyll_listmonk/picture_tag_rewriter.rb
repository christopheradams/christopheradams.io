module JekyllListmonk
  class PictureTagRewriter
    def initialize(preset: "newsletter")
      @preset = preset
    end

    def rewrite(markdown, frontmatter_image:)
      content = markdown.to_s
      content = inject_frontmatter_image_picture_tag(content, frontmatter_image)
      rewrite_picture_tags_for_newsletter(content)
    end

    def strip_responsive_img_attributes(html)
      html.to_s
        .gsub(/\s+srcset=(\"[^\"]*\"|'[^']*')/, "")
        .gsub(/\s+sizes=(\"[^\"]*\"|'[^']*')/, "")
    end

    private

    def rewrite_picture_tags_for_newsletter(markdown)
      out = +""
      lines = markdown.to_s.lines

      i = 0
      while i < lines.length
        line = lines[i]

        if line.lstrip.start_with?("{% picture")
          tag = +""
          loop do
            tag << lines[i]
            i += 1
            break if tag.include?("%}") || i >= lines.length
          end

          out << transform_picture_tag(tag)
          next
        end

        out << line
        i += 1
      end

      out
    end

    def transform_picture_tag(tag)
      m = tag.match(/\A(\s*)\{\%\s*picture\s+([\s\S]*?)\s*\%\}(\s*)\z/)
      return tag unless m

      leading_ws = m[1]
      inner = m[2]
      trailing_ws = m[3]

      inner_lstripped = inner.lstrip

      # If the tag doesn't already specify a preset, insert our newsletter preset.
      if inner_lstripped.start_with?("/") || inner_lstripped.start_with?("./") || inner_lstripped.start_with?("../")
        inner = "#{@preset} " + inner_lstripped
      else
        inner = inner_lstripped
      end

      # Remove `--img class="..."` (and single-quote variant).
      inner = inner.gsub(/\s+--img\s+class=(\"[^\"]*\"|'[^']*')/, "")

      "#{leading_ws}{% picture #{inner.rstrip} %}#{trailing_ws}"
    end

    def inject_frontmatter_image_picture_tag(markdown, image_field)
      content = markdown.to_s

      image_path, image_alt = extract_frontmatter_image(image_field)
      return content if image_path.nil? || image_path.to_s.strip.empty?

      image_path = normalize_image_path(image_path)

      tag = +"{% picture #{image_path}"
      if image_alt && !image_alt.to_s.strip.empty?
        tag << %( --alt "#{escape_liquid_double_quotes(one_line(image_alt))}")
      end
      tag << " %}\n"

      first_picture = first_picture_block(content)
      return content if first_picture && first_picture.include?(image_path)

      tag + "\n" + content
    end

    def first_picture_block(markdown)
      lines = markdown.to_s.lines
      i = 0
      while i < lines.length
        line = lines[i]
        if line.strip.empty?
          i += 1
          next
        end

        return nil unless line.lstrip.start_with?("{% picture")

        block = +""
        loop do
          block << lines[i]
          i += 1
          break if block.include?("%}") || i >= lines.length
        end
        return block
      end
      nil
    end

    def extract_frontmatter_image(image_field)
      case image_field
      when String
        [image_field, nil]
      when Hash
        path = image_field["path"] || image_field[:path]
        title = image_field["title"] || image_field[:title]
        [path, title]
      else
        [nil, nil]
      end
    end

    def normalize_image_path(path)
      p = path.to_s.strip
      return p if p.empty?
      p = "/#{p}" unless p.start_with?("/", "./", "../")
      p
    end

    def one_line(s)
      s.to_s.gsub(/\s+/, " ").strip
    end

    def escape_liquid_double_quotes(s)
      s.to_s.gsub("\\", "\\\\").gsub('"', '\"')
    end
  end
end

