module OpenXML4Ruby

  module ContentType
    class Default
      attr_reader :content_type
      attr_reader :extension

      def initialize(content_type, extension)
        @extension = extension
        @content_type = content_type
      end

      def to_xml(xml)
        xml.Default(:Extension => extension, :ContentType => content_type)
      end
    end

    class Override
      attr_reader :content_type
      attr_reader :part_name

      def initialize(content_type, part_name)
        @part_name = part_name
        @content_type = content_type
      end

      def to_xml(xml)
        xml.Override(:PartName => part_name, :ContentType => content_type)
      end
    end
  end

  class ContentTypes
    include Enumerable

    def initialize
      @content_types = []
    end

    def each
      @content_types.each do |ct|
        yield ct
      end
    end

    def <<(content_type)
      @content_types << content_type
      self
    end

    def to_xml
      xml_string = ""
      xml = Builder::XmlMarkup.new(:target=> xml_string)
      xml.instruct!(:xml, :encoding => "UTF-8", :standalone => "yes")
      xml.Types(:xmlns=>"http://schemas.openxmlformats.org/package/2006/content-types") do
        self.each{ |r| r.to_xml(xml) }
      end
      xml_string
    end
  end

end
