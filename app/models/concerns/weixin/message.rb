# ref https://github.com/Empact/roxml
require 'roxml'
# ref https://github.com/sferik/multi_xml
require 'multi_xml'
# ref http://www.ruby-doc.org/stdlib-2.0/libdoc/ostruct/rdoc/OpenStruct.html
require 'ostruct'

MultiXml.parser = :nokogiri

class Message
  def initialize(hash)
    @source = OpenStruct.new(hash)
  end

  def method_missing(method, *args, &block)
    @source.send(method, *args, &block)
  end

  def CreateTime
    @source.CreateTime.to_i
  end

  def MsgId
    @source.MsgId.to_i
  end

  def self.factory(xml)
    hash = MultiXml.parse(xml)['xml']
    case hash['MsgType']
    when 'text'
      TextMessage.new(hash)
    when 'image'
      ImageMessage.new(hash)
    when 'location'
      LocationMessage.new(hash)
    when 'link'
      LinkMessage.new(hash)
    when 'event'
      EventMessage.new(hash)
    when 'voice'
      VoiceMessage.new(hash)
    when 'video'
      VideoMessage.new(hash)
    else
      raise ArgumentError, 'Unknown Message'
    end
  end

end

TextMessage = Class.new(Message)

ImageMessage = Class.new(Message)

LinkMessage = Class.new(Message)

EventMessage = Class.new(Message)

class LocationMessage < Message

  def Location_X
    @source.Location_X.to_f
  end

  def Location_Y
    @source.Location_Y.to_f
  end

  def Scale
    @source.Scale.to_i
  end
end

class VoiceMessage < Message

  def MediaId
    @source.MediaId
  end

  def Format
    @source.Format
  end
end

class VideoMessage < Message

  def MediaId
    @source.MediaId
  end

  def ThumbMediaId
    @source.ThumbMediaId
  end
end
