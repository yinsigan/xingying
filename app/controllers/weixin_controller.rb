class WeixinController < ApplicationController
  include Weixin::ReplyMessageHelper
  skip_before_action :verify_authenticity_token
  before_action :initialize_adapter, :check_weixin_legality, only: [:index, :reply]
  before_action :set_weixin_message, :set_keyword, only: :reply

  def index
  end

  def reply
    render xml: send("response_#{@weixin_message.MsgType}_message", {})
  end

  protected

    def initialize_adapter
      @weixin_adapter ||= Weixin::Adapter.new(params)
    end

    def check_weixin_legality
      check_result = @weixin_adapter.check_weixin_legality
      valid = check_result.delete(:valid)
      render check_result if action_name == "index"
      return valid
    end

    def set_weixin_message
      @weixin_message ||= Weixin::Message.factory(request.body.read)
    end

    def set_keyword
      @keyword = @weixin_message.Content
                 @weixin_message.EventKey
                 @weixin_message.Recognition
    end

  private

    def response_text_message(options={})
      reply_text_message("Your Message: #{@keyword}")
    end
end
