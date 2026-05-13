<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>
<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteTable.Routes.MapPageRoute("", "*.", "~/NotFound.aspx");
        RouteTable.Routes.MapPageRoute("", "login", "~/login.aspx");
        RouteTable.Routes.MapPageRoute("", "auth", "~/Default.aspx");
        RouteTable.Routes.MapPageRoute("", "Login", "~/Default.aspx"); 
        RouteTable.Routes.MapPageRoute("", "dashboard", "~/Default.aspx");
        RouteTable.Routes.MapPageRoute("", "ResourceType", "~/BoardResourceTypes.aspx");

        RouteTable.Routes.MapPageRoute("", "", "~/.aspx");
        RouteTable.Routes.MapPageRoute("", "AboutUs", "~/AboutUs.aspx");
        RouteTable.Routes.MapPageRoute("", "Blogs", "~/Blogs.aspx");
        RouteTable.Routes.MapPageRoute("", "BlogDetails", "~/BlogDetails.aspx");


        RouteTable.Routes.MapPageRoute("", "", "~/.aspx");

        RouteTable.Routes.MapPageRoute("", "ManageUser", "~/member/ManageUser.aspx");
        RouteTable.Routes.MapPageRoute("", "ChnageKeySecret", "~/member/ChnageKeySecret.aspx");
        RouteTable.Routes.MapPageRoute("", "ManageBindingKey", "~/member/ManageBindingStatus.aspx");
        RouteTable.Routes.MapPageRoute("", "Margincallsetting", "~/member/Margin_call_setting.aspx");
        RouteTable.Routes.MapPageRoute("", "Tradesetting", "~/member/Trade_call_setting.aspx");
        RouteTable.Routes.MapPageRoute("", "ChnageMemberPass", "~/member/ChnageMPass.aspx");
        RouteTable.Routes.MapPageRoute("", "manageprofile", "~/member/MangeProfie.aspx");
        RouteTable.Routes.MapPageRoute("", "DeductFund", "~/member/Deduct_fund.aspx");
        RouteTable.Routes.MapPageRoute("","Depositfund", "~/member/Depositfund.aspx");
        RouteTable.Routes.MapPageRoute("", "PaymentSetting", "~/member/PaymentSetting.aspx");
        RouteTable.Routes.MapPageRoute("", "MangeBanner", "~/member/Manage_Banner.aspx");
        RouteTable.Routes.MapPageRoute("", "MangeCircle", "~/member/MangeCircle.aspx");
        RouteTable.Routes.MapPageRoute("", "AddBanner", "~/member/AddBanner.aspx");
        RouteTable.Routes.MapPageRoute("", "SearchUser", "~/member/Get_userid.aspx");
        RouteTable.Routes.MapPageRoute("", "Accstatement", "~/member/Acc_statement.aspx");
        RouteTable.Routes.MapPageRoute("", "AddPayment", "~/member/AddCurrency.aspx");
        RouteTable.Routes.MapPageRoute("", "Master_CurrencyOld", "~/member/Master_CurrencyOld.aspx");
        RouteTable.Routes.MapPageRoute("", "DepositList", "~/member/DepositList.aspx");
        RouteTable.Routes.MapPageRoute("", "ApiDepositList", "~/member/Api_DepositList.aspx");
        RouteTable.Routes.MapPageRoute("", "WithdrawList", "~/member/WithdrawList.aspx");
        RouteTable.Routes.MapPageRoute("", "TradeList", "~/member/TradeList.aspx");
        RouteTable.Routes.MapPageRoute("", "UserRank", "~/member/UserRank.aspx");
        RouteTable.Routes.MapPageRoute("", "ActiveUserList", "~/member/ActiveUserList.aspx");
        RouteTable.Routes.MapPageRoute("", "Inactiveuserlist", "~/member/Inactiveuserlist.aspx");
        RouteTable.Routes.MapPageRoute("", "Newuser", "~/member/Transfer.aspx");
        RouteTable.Routes.MapPageRoute("", "Reinvest", "~/member/Reinvest.aspx");
        RouteTable.Routes.MapPageRoute("", "MasterAccount", "~/member/MasterAccount.aspx");
        RouteTable.Routes.MapPageRoute("", "ManageMasterAccount", "~/member/ManageMasterAccount.aspx");
        RouteTable.Routes.MapPageRoute("", "ManageCurrency", "~/member/ManageCurrency.aspx");
        RouteTable.Routes.MapPageRoute("", "AllCurrency", "~/member/AllCurrency.aspx");
        RouteTable.Routes.MapPageRoute("", "FollowerDetails", "~/member/FollowerDetails.aspx");
        RouteTable.Routes.MapPageRoute("", "UserAllTeam", "~/member/UserAllTeam.aspx");
        RouteTable.Routes.MapPageRoute("", "FollowerConnectionInfo", "~/member/FollowerConnectionInfo.aspx");
        RouteTable.Routes.MapPageRoute("", "UpdateMasterAccount", "~/member/UpdateMasterAccount.aspx");
        RouteTable.Routes.MapPageRoute("", "GuessFeesDistribution", "~/member/GuessFeesDistribution.aspx");
        RouteTable.Routes.MapPageRoute("", "Tradereport", "~/member/Tradereport.aspx");
        RouteTable.Routes.MapPageRoute("", "WithdrawHistory", "~/member/WithdrawHistory.aspx");
        RouteTable.Routes.MapPageRoute("", "UserGasfeeDetail", "~/member/UserGasfeeDetail.aspx");
        RouteTable.Routes.MapPageRoute("", "ManageSubAdmin", "~/member/ManageSubAdmin.aspx");
        RouteTable.Routes.MapPageRoute("", "AddUser", "~/member/AddSubAdmin.aspx");
        RouteTable.Routes.MapPageRoute("", "ApproveTicket", "~/member/ApproveTicket.aspx");
        RouteTable.Routes.MapPageRoute("", "TicketDetail", "~/member/TicketDetail.aspx");
        RouteTable.Routes.MapPageRoute("", "MangebalancePL", "~/member/MangebalancePL.aspx");
        RouteTable.Routes.MapPageRoute("", "PLActivationHistory", "~/member/PLActivationHistory.aspx");
        RouteTable.Routes.MapPageRoute("", "DepositReport", "~/member/DepositReport.aspx");
        RouteTable.Routes.MapPageRoute("", "SyncBalanceToAdmin", "~/member/SyncBalanceToAdmin.aspx");
        RouteTable.Routes.MapPageRoute("", "TradingProfitPoolReport", "~/member/TradingProfitPoolReport.aspx");
        RouteTable.Routes.MapPageRoute("", "MasterAccountRequestList", "~/member/MasterAccountRequestList.aspx");
        RouteTable.Routes.MapPageRoute("", "CreateUserMasterAccount", "~/member/CreateUserMasterAccount.aspx");
        RouteTable.Routes.MapPageRoute("", "ManageMasterDetail", "~/member/ManageMasterDetail.aspx");
        RouteTable.Routes.MapPageRoute("", "DepositeTransaction", "~/member/DepositeTransaction.aspx");
        RouteTable.Routes.MapPageRoute("", "USerpayment", "~/member/USerpayment.aspx");
        RouteTable.Routes.MapPageRoute("", "Reset2FA", "~/member/Reset2FA.aspx");
        RouteTable.Routes.MapPageRoute("", "OpenTradereport", "~/member/OpenTradereport.aspx");
        RouteTable.Routes.MapPageRoute("", "ChnageKeySecret", "~/member/ChnageKeySecret.aspx");
        RouteTable.Routes.MapPageRoute("", "MasterCurrencyCrypto", "~/member/Master_CurrencyCrypto.aspx");
        RouteTable.Routes.MapPageRoute("", "Tradesetting", "~/member/Trade_call_setting.aspx");
        RouteTable.Routes.MapPageRoute("", "opentrade", "~/member/Opentrade.aspx");
        RouteTable.Routes.MapPageRoute("", "closetrade", "~/member/Closetrade.aspx");
        RouteTable.Routes.MapPageRoute("", "Usercryptotradereport", "~/member/Usercrypotradereport.aspx");
        RouteTable.Routes.MapPageRoute("", "Addspotmaster", "~/member/Addspotmaster.aspx");
        RouteTable.Routes.MapPageRoute("", "ManageSpotMaster", "~/member/ManageSpotMaster.aspx");
        RouteTable.Routes.MapPageRoute("", "strattrade", "~/member/Cryptostarttrade.aspx");
        RouteTable.Routes.MapPageRoute("", "managecryptotrade", "~/member/Managecryptotrade.aspx");
        RouteTable.Routes.MapPageRoute("", "Addnews", "~/member/Editnew.aspx");
        RouteTable.Routes.MapPageRoute("", "ApiBindUserList", "~/member/ApiUserlist.aspx");
        RouteTable.Routes.MapPageRoute("", "TodayDepositList", "~/member/DepositReportToday.aspx");
        RouteTable.Routes.MapPageRoute("", "TodayAdminDepositList", "~/member/DepositAdmintoday.aspx");
        RouteTable.Routes.MapPageRoute("", "TodayTCPDepositList", "~/member/DepositReportTCPToday.aspx");
        RouteTable.Routes.MapPageRoute("", "TodayIncomelist", "~/member/Incomelist.aspx");
        RouteTable.Routes.MapPageRoute("", "Fstrattrade", "~/member/F_cryptostarttrade.aspx");
        RouteTable.Routes.MapPageRoute("", "F_managecryptotrade", "~/member/F_managecryptotrade.aspx");
        RouteTable.Routes.MapPageRoute("", "AdminActivationlist", "~/member/AdminActivationlist.aspx");
        RouteTable.Routes.MapPageRoute("", "ActivationWithoutIBV", "~/member/ActivationWithoutIBV.aspx");
        RouteTable.Routes.MapPageRoute("", "PowerLeg", "~/member/PowerLeg.aspx");
        RouteTable.Routes.MapPageRoute("", "Spotusertradelist", "~/member/Spotusertradelist.aspx");
        RouteTable.Routes.MapPageRoute("", "Futureusertradelist", "~/member/Futureusertradelist.aspx");
        RouteTable.Routes.MapPageRoute("", "Transfergaswallet", "~/member/Transfergaswallet.aspx");
        RouteTable.Routes.MapPageRoute("", "Gaswalletlist", "~/member/Gaswalletlist.aspx");
        RouteTable.Routes.MapPageRoute("", "changewalletid", "~/member/changewalletid.aspx");
        RouteTable.Routes.MapPageRoute("", "CryptoStrategy", "~/member/Crypto_Strategy.aspx");
        RouteTable.Routes.MapPageRoute("", "strategySetting", "~/member/StrategySettinglist.aspx");
        RouteTable.Routes.MapPageRoute("", "addstrategy", "~/member/Addstrategy.aspx");
        RouteTable.Routes.MapPageRoute("", "spottradeactivation", "~/member/spot_tradeactivation.aspx");
        RouteTable.Routes.MapPageRoute("", "Futuretradeactivation", "~/member/Future_tradeactivation.aspx");
        RouteTable.Routes.MapPageRoute("", "managefutureactivetrade", "~/member/Managefutureactivetrade.aspx");
        RouteTable.Routes.MapPageRoute("", "managespotactivetrade", "~/member/Managespotactivetrade.aspx");
        RouteTable.Routes.MapPageRoute("", "completedcrypotradereport", "~/member/completedcrypotradereport.aspx");
        RouteTable.Routes.MapPageRoute("", "mtpendingrequest", "~/member/Mt5requestuser.aspx");
        RouteTable.Routes.MapPageRoute("", "allmtuserlist", "~/member/Allmtuserlist.aspx");
        RouteTable.Routes.MapPageRoute("", "DistributeProfit", "~/member/DistributeProfit.aspx");
        RouteTable.Routes.MapPageRoute("", "Elbezafundlist", "~/member/Elbezafundlist.aspx");
        RouteTable.Routes.MapPageRoute("", "BinaryActivatedList", "~/member/BinaryActivatedList.aspx");

        Application["TotalOnlineUsers"] = 0;
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        Application.Lock();
        Application["TotalOnlineUsers"] = (int)Application["TotalOnlineUsers"] + 1;
        Application.UnLock();
    }

    void Session_End(object sender, EventArgs e)
    {
        Application.Lock();
        Application["TotalOnlineUsers"] = (int)Application["TotalOnlineUsers"] - 1;
        Application.UnLock();

    }

</script>