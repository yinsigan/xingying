module SettingsHelper

  # 重写面包屑
  def render_breadcrumbs(options = {}, &block)
    content_tag "ol", class: "breadcrumb" do
      breadcrumbs.collect do |element|
        render_element(element)
      end.join.html_safe
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  private

    def render_element(element)
      if element.path == nil
        content = compute_name(element)
      else
        content = self.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      end
      if current_page?(compute_path(element))
        self.content_tag("li", content, class: "active")
      else
        self.content_tag("li", content)
      end
    end

    def compute_name(element)
      case name = element.name
      when Symbol
        self.send(name)
      when Proc
        name.call(self)
      else
        name.to_s
      end
    end

    def compute_path(element)
      case path = element.path
      when Symbol
        self.send(path)
      when Proc
        path.call(self)
      else
        self.url_for(path)
      end
    end

end
