class Weixin::Adapter
  attr_accessor :signature, :timestamp, :nonce, :echostr
  attr_accessor :weixin_secret_key

  def initialize(params)
    @weixin_secret_key = params[:weixin_secret_key]
    @signature = params[:signature] || ''
    @timestamp = params[:timestamp] || ''
    @nonce     = params[:nonce]     || ''
    @echostr   = params[:echostr]   || ''
  end

  def check_weixin_legality
    return render_authorize_result(404) if !is_weixin_secret_key_valid?
    return render_authorize_result(403, self.class.error_msg) if !is_signature_valid?
    render_authorize_result(200, echostr, true)
  end

  def is_signature_valid?
    sort_params = [current_weixin_token, timestamp, nonce].sort.join
    current_signature = Digest::SHA1.hexdigest(sort_params)
    return true if current_signature == signature
    false
  end

  def current_weixin_public_account
    Public.where(:weixin_secret_key => @weixin_secret_key).first
  end

  def current_weixin_token
    current_weixin_public_account.try(:weixin_token)
  end

  def is_weixin_secret_key_valid?
    current_weixin_public_account.present?
  end
  class << self
    def error_msg
      "#{__FILE__}:#{__LINE__}: Weixin signature NotMatch"
    end
  end

  private

  def render_authorize_result(status=403, text=nil, valid=false)
    text = text || error_msg
    Rails.logger.error(text) if status != 200
    {text: text, status: status, valid: valid}
  end

  def error_msg
    self.class.error_msg
  end

end
