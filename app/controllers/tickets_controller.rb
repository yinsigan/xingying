class TicketsController < SettingsController
  layout "not_show_pa"
  before_action :add_index_breadcrumb

  def index
    @tickets = current_user.tickets.all
  end

  def new
    add_breadcrumb I18n.t("breadcrumbs.ticket.new"), :new_ticket_path
    @ticket = current_user.tickets.build
  end

  def create
    add_breadcrumb I18n.t("breadcrumbs.ticket.new"), :new_ticket_path
    @ticket = current_user.tickets.build(ticket_params)
    if @ticket.save
      redirect_to tickets_path, flash: {success: I18n.t('success_submit')}
    else
      render :new
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :number, :body, :status)
  end

  def add_index_breadcrumb
    add_breadcrumb I18n.t("breadcrumbs.ticket.index"), :tickets_path
  end

end