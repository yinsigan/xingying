class TicketsController < SettingsController
  layout "public_account_manage"
  before_action :add_index_breadcrumb

  def index
    @tickets = current_user.tickets.page(params[:page]).per(2)
  end

  def all
    @tickets = Ticket.includes(:user).page(params[:all_tickets]).per(20) if current_user.can_admin?
    add_breadcrumb I18n.t("breadcrumbs.ticket.all"), :all_tickets_path
    render action: :index
  end

  def new
    add_breadcrumb I18n.t("breadcrumbs.ticket.new"), :new_ticket_path
    @ticket = current_user.tickets.build
  end

  def create
    add_breadcrumb I18n.t("breadcrumbs.ticket.new"), :new_ticket_path
    @ticket = current_user.tickets.build(ticket_params)
    if @ticket.save
      CreateTicketAdminNoticeWorker.perform_async(@ticket.id)
      redirect_to @ticket, flash: {success: I18n.t('success_submit')}
    else
      render :new
    end
  end

  def show
    if current_user.can_admin?
      @ticket = Ticket.find(params[:id])
    else
      @ticket = current_user.tickets.find(params[:id])
    end
    @comments = @ticket.comments.includes(:user).order(id: :asc).page(params[:page])
    add_breadcrumb @ticket.title, ticket_path(@ticket)
    @comment = @ticket.comments.build
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :number, :body, :status)
  end

  def add_index_breadcrumb
    add_breadcrumb I18n.t("breadcrumbs.ticket.index"), :tickets_path
  end

end