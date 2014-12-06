module Weixin
  module ReplyMessageHelper
    def reply_text_message(from=nil, to=nil, content)
      message = TextReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Content      = content
      message.to_xml
    end

    def generate_article(title, desc, pic_url, link_url)
      item = Article.new
      item.Title       = title
      item.Description = desc
      item.PicUrl = pic_url
      item.Url    = link_url
      item
    end

    # articles = [generate_article]
    def reply_news_message(from=nil, to=nil, articles)
      message = NewsReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Articles     = articles
      message.ArticleCount = articles.count
      message.to_xml
    end

    # 启动多客服模式
    def reply_transfer_customer_service_message(from=nil, to=nil)
      message = TransferCustomerServiceReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.to_xml
    end
  end
end
