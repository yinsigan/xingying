class WeixinController < ApplicationController
  include Weixin::ReplyMessageHelper
  skip_before_action :verify_authenticity_token
  before_action :initialize_adapter, :check_weixin_legality, only: [:index, :reply]
  before_action :set_weixin_public_account, :set_weixin_message, :set_keyword, only: :reply

  def index
  end

  def reply
    render xml: send("response_#{@weixin_message.MsgType}_message", {})
  end

  protected

    # 参数初始化，查找公众账号
    def initialize_adapter
      @weixin_adapter ||= Weixin::Adapter.new(params)
    end

    # 验证
    def check_weixin_legality
      check_result = @weixin_adapter.check_weixin_legality
      valid = check_result.delete(:valid)
      render check_result if action_name == "index"
      return valid
    end

    # 当前公众账号
    def set_weixin_public_account
      @weixin_public_account ||= @weixin_adapter.current_weixin_public_account
    end

    # 设置接收微信消息
    def set_weixin_message
      @weixin_message ||= Weixin::Message.factory(request.body.read)
    end

    def set_keyword
      @keyword = @weixin_message.Content
                 @weixin_message.EventKey
                 @weixin_message.Recognition
    end

    def response_event_message(options={})
      event_type = @weixin_message.Event
      send("handle_#{event_type.downcase}_event")
    end

  private

    # 关键字回复
    def response_text_message(options={})
      # reply_transfer_customer_service_message
      if @find_kword = @weixin_public_account.kwords.where(:name => @keyword).last
        case @find_kword.subjectable_type
        when "TextMaterial"
          reply_text_message(@find_kword.reply.presence)
        when "SinMaterial"
          if sin_pic_text = @find_kword.sin_material.try(:sin_pic_text)
            reply_news_message(custom_generate_article(sin_pic_text))
          end
        end
      # 回复文字无匹配时
      else
        case @weixin_public_account.autoreply_type
        when 1
          if @weixin_public_account.autoreply.present?
            reply_text_message(@weixin_public_account.autoreply.presence)
          else
            reply_text_message("")
          end
        when 2
          if sin_pic_text = @weixin_public_account.autoreply_sin_material.try(:sin_pic_text)
            reply_news_message(custom_generate_article(sin_pic_text))
          end
        end
      end
    end

    # 首次关注
    def handle_subscribe_event
      if @keyword.present?
        return reply_text_message("扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送, keyword: #{@keyword}")
      end
      case @weixin_public_account.reply_type
      when 1
        reply_text_message(@weixin_public_account.default_reply.presence)
      when 2
        if sin_pic_text = @weixin_public_account.default_sin_material.try(:sin_pic_text)
          reply_news_message(custom_generate_article(sin_pic_text))
        end
      end
    end

    def custom_generate_article(sin_pic_text)
      articles = []
      article = generate_article(sin_pic_text.title,
                                 sin_pic_text.desc,
                                 sin_pic_text.pic_url,
                                 sin_pic_text.article_address.presence)
      articles << article
    end

    # 点击菜单拉取消息时的事件推送
    def handle_click_event
      # 取出key值与数据库比库
      if @weixin_message.EventKey.present?
        if @click_event_menu = @weixin_public_account.menus.where(:tp => "click", :key => @weixin_message.EventKey.to_s).first
          case @click_event_menu.click_type
          when 1
            reply_text_message(@click_event_menu.click_body.presence)
          when 2
            if sin_pic_text = @click_event_menu.sin_material.try(:sin_pic_text)
              reply_news_message(custom_generate_article(sin_pic_text))
            end
          end
        else
          reply_text_message("数据错误，或者未设置好appid和appsecret")
        end
      end
    end

end
