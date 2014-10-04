class WeixinController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :initialize_adapter, :check_weixin_legality, only: [:index, :reply]

  def index
  end

  def reply
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

end
