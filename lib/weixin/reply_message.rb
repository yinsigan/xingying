require 'roxml'

module Weixin

  class ReplyMessage
    include ROXML
    xml_name :xml

    xml_accessor :ToUserName, :cdata   => true
    xml_accessor :FromUserName, :cdata => true
    xml_reader   :CreateTime, :as => Integer
    xml_reader   :MsgType, :cdata => true

    def initialize
      @CreateTime = Time.now.to_i
    end

    def to_xml
      super.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
    end
  end

  class TextReplyMessage < ReplyMessage
    xml_accessor :Content, :cdata => true
    def initialize
      super
      @MsgType = 'text'
    end
  end

  class Music
    include ROXML
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :MusicUrl,   :cdata => true
    xml_accessor :HQMusicUrl, :cdata => true
  end

  class MusicReplyMessage < ReplyMessage
    xml_accessor :Music, :as => Music
    def initialize
      super
      @MsgType = 'music'
    end
  end

  class Article
    include ROXML
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :PicUrl, :cdata => true
    xml_accessor :Url,    :cdata => true
  end


  class NewsReplyMessage < ReplyMessage
    xml_accessor :ArticleCount, :as => Integer
    xml_accessor :Articles, :as => [Article], :in => 'Articles', :from => 'item'
    def initialize
      super
      @MsgType = 'news'
    end
  end

  class Video
    include ROXML
    xml_accessor :MediaId, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :Title, :cdata => true
  end

  class VideoReplyMessage < ReplyMessage
    xml_accessor :Video, :as => Video
    def initialize
      super
      @MsgType = 'video'
    end
  end

  class Voice
    include ROXML
    xml_accessor :MediaId, :cdata => true
  end

  class VoiceReplyMessage < ReplyMessage
    xml_accessor :Voice, :as => Voice
    def initialize
      super
      @MsgType = 'voice'
    end
  end

  class Image
    include ROXML
    xml_accessor :MediaId, :cdata => true
  end

  class ImageReplyMessage < ReplyMessage
    xml_accessor :Image, :as => Image
    def initialize
      super
      @MsgType = 'image'
    end
  end

  class TransferCustomerServiceReplyMessage < ReplyMessage
    def initialize
      super
      @MsgType = 'transfer_customer_service'
    end
  end
end
