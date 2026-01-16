defmodule LiveschoolWeb.Router do
  use LiveschoolWeb, :router

  import LiveschoolWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveschoolWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveschoolWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/schools", SchoolLive.Index, :index
    live "/schools/new", SchoolLive.Index, :new
    live "/schools/:id/edit", SchoolLive.Index, :edit

    live "/schools/:id", SchoolLive.Show, :show
    live "/schools/:id/show/edit", SchoolLive.Show, :edit

    live "/terms", TermLive.Index, :index
    live "/terms/new", TermLive.Index, :new
    live "/terms/:id/edit", TermLive.Index, :edit

    live "/terms/:id", TermLive.Show, :show
    live "/terms/:id/show/edit", TermLive.Show, :edit

    live "/departments", DepartmentLive.Index, :index
    live "/departments/new", DepartmentLive.Index, :new
    live "/departments/:id/edit", DepartmentLive.Index, :edit

    live "/departments/:id", DepartmentLive.Show, :show
    live "/departments/:id/show/edit", DepartmentLive.Show, :edit

    live "/students", StudentLive.Index, :index
    live "/students/new", StudentLive.Index, :new
    live "/students/:id/edit", StudentLive.Index, :edit

    live "/students/:id", StudentLive.Show, :show
    live "/students/:id/show/edit", StudentLive.Show, :edit

    live "/classes", ClassLive.Index, :index
    live "/classes/new", ClassLive.Index, :new
    live "/classes/:id/edit", ClassLive.Index, :edit

    live "/classes/:id", ClassLive.Show, :show
    live "/classes/:id/show/edit", ClassLive.Show, :edit

    live "/staff_members", StaffMemberLive.Index, :index
    live "/staff_members/new", StaffMemberLive.Index, :new
    live "/staff_members/:id/edit", StaffMemberLive.Index, :edit

    live "/staff_members/:id", StaffMemberLive.Show, :show
    live "/staff_members/:id/show/edit", StaffMemberLive.Show, :edit

    live "/fee_structures", FeeStructureLive.Index, :index
    live "/fee_structures/new", FeeStructureLive.Index, :new
    live "/fee_structures/:id/edit", FeeStructureLive.Index, :edit

    live "/fee_structures/:id", FeeStructureLive.Show, :show
    live "/fee_structures/:id/show/edit", FeeStructureLive.Show, :edit

    live "/student_fee_allocations", StudentFeeAllocationLive.Index, :index
    live "/student_fee_allocations/new", StudentFeeAllocationLive.Index, :new
    live "/student_fee_allocations/:id/edit", StudentFeeAllocationLive.Index, :edit

    live "/student_fee_allocations/:id", StudentFeeAllocationLive.Show, :show
    live "/student_fee_allocations/:id/show/edit", StudentFeeAllocationLive.Show, :edit

    live "/fee_waivers", FeeWaiverLive.Index, :index
    live "/fee_waivers/new", FeeWaiverLive.Index, :new
    live "/fee_waivers/:id/edit", FeeWaiverLive.Index, :edit

    live "/fee_waivers/:id", FeeWaiverLive.Show, :show
    live "/fee_waivers/:id/show/edit", FeeWaiverLive.Show, :edit

    live "/fee_arrears", FeeArrearLive.Index, :index
    live "/fee_arrears/new", FeeArrearLive.Index, :new
    live "/fee_arrears/:id/edit", FeeArrearLive.Index, :edit

    live "/fee_arrears/:id", FeeArrearLive.Show, :show
    live "/fee_arrears/:id/show/edit", FeeArrearLive.Show, :edit

    live "/fee_receipts", FeeReceiptLive.Index, :index
    live "/fee_receipts/new", FeeReceiptLive.Index, :new
    live "/fee_receipts/:id/edit", FeeReceiptLive.Index, :edit

    live "/fee_receipts/:id", FeeReceiptLive.Show, :show
    live "/fee_receipts/:id/show/edit", FeeReceiptLive.Show, :edit

    live "/fee_receipt_items", FeeReceiptItemLive.Index, :index
    live "/fee_receipt_items/new", FeeReceiptItemLive.Index, :new
    live "/fee_receipt_items/:id/edit", FeeReceiptItemLive.Index, :edit

    live "/fee_receipt_items/:id", FeeReceiptItemLive.Show, :show
    live "/fee_receipt_items/:id/show/edit", FeeReceiptItemLive.Show, :edit

    live "/vote_heads", VoteHeadLive.Index, :index
    live "/vote_heads/new", VoteHeadLive.Index, :new
    live "/vote_heads/:id/edit", VoteHeadLive.Index, :edit

    live "/vote_heads/:id", VoteHeadLive.Show, :show
    live "/vote_heads/:id/show/edit", VoteHeadLive.Show, :edit

    live "/expenditures", ExpenditureLive.Index, :index
    live "/expenditures/new", ExpenditureLive.Index, :new
    live "/expenditures/:id/edit", ExpenditureLive.Index, :edit

    live "/expenditures/:id", ExpenditureLive.Show, :show
    live "/expenditures/:id/show/edit", ExpenditureLive.Show, :edit

    live "/suppliers", SupplierLive.Index, :index
    live "/suppliers/new", SupplierLive.Index, :new
    live "/suppliers/:id/edit", SupplierLive.Index, :edit

    live "/suppliers/:id", SupplierLive.Show, :show
    live "/suppliers/:id/show/edit", SupplierLive.Show, :edit

    live "/bank_accounts", BankAccountLive.Index, :index
    live "/bank_accounts/new", BankAccountLive.Index, :new
    live "/bank_accounts/:id/edit", BankAccountLive.Index, :edit

    live "/bank_accounts/:id", BankAccountLive.Show, :show
    live "/bank_accounts/:id/show/edit", BankAccountLive.Show, :edit

    live "/bank_transactions", BankTransactionLive.Index, :index
    live "/bank_transactions/new", BankTransactionLive.Index, :new
    live "/bank_transactions/:id/edit", BankTransactionLive.Index, :edit

    live "/bank_transactions/:id", BankTransactionLive.Show, :show

    live "/bank_transactions/:id/show/edit", BankTransactionLive.Show, :edit

    live "/petty_cash_transactions", PettyCashTransactionLive.Index, :index
    live "/petty_cash_transactions/new", PettyCashTransactionLive.Index, :new
    live "/petty_cash_transactions/:id/edit", PettyCashTransactionLive.Index, :edit

    live "/petty_cash_transactions/:id", PettyCashTransactionLive.Show, :show
    live "/petty_cash_transactions/:id/show/edit", PettyCashTransactionLive.Show, :edit

    live "/imprest_issues", ImprestIssueLive.Index, :index
    live "/imprest_issues/new", ImprestIssueLive.Index, :new
    live "/imprest_issues/:id/edit", ImprestIssueLive.Index, :edit

    live "/imprest_issues/:id", ImprestIssueLive.Show, :show
    live "/imprest_issues/:id/show/edit", ImprestIssueLive.Show, :edit

    live "/pocket_money_transactions", PocketMoneyTransactionLive.Index, :index
    live "/pocket_money_transactions/new", PocketMoneyTransactionLive.Index, :new
    live "/pocket_money_transactions/:id/edit", PocketMoneyTransactionLive.Index, :edit

    live "/pocket_money_transactions/:id", PocketMoneyTransactionLive.Show, :show
    live "/pocket_money_transactions/:id/show/edit", PocketMoneyTransactionLive.Show, :edit

    live "/school_assets", SchoolAssetLive.Index, :index
    live "/school_assets/new", SchoolAssetLive.Index, :new
    live "/school_assets/:id/edit", SchoolAssetLive.Index, :edit

    live "/school_assets/:id", SchoolAssetLive.Show, :show
    live "/school_assets/:id/show/edit", SchoolAssetLive.Show, :edit

    live "/audit_logs", AuditLogLive.Index, :index
    live "/audit_logs/new", AuditLogLive.Index, :new
    live "/audit_logs/:id/edit", AuditLogLive.Index, :edit

    live "/audit_logs/:id", AuditLogLive.Show, :show
    live "/audit_logs/:id/show/edit", AuditLogLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveschoolWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:liveschool, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveschoolWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", LiveschoolWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{LiveschoolWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", LiveschoolWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{LiveschoolWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", LiveschoolWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{LiveschoolWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
