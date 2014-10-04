module Weixin
  module ReplyMessageHelper
    def reply_text_message(from=nil, to=nil, content)
      message = TextReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Content      = content
      message.to_xml
    end
  end
end
