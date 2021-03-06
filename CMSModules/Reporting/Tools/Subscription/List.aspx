<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master"
    Theme="Default" Inherits="CMSModules_Reporting_Tools_Subscription_List" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>
<asp:Content ContentPlaceHolderID="plcContent" ID="content" runat="server">
    <cms:UniGrid runat="server" ID="gridElem" ObjectType="reporting.reportsubscription"
        OrderBy="ReportSubscriptionEmail" Columns="ReportSubscriptionID,ReportSubscriptionEnabled,ReportSubscriptionEmail,ReportSubscriptionSubject"
        IsLiveSite="false">
        <GridActions Parameters="ReportSubscriptionID">
            <ug:Action Name="edit" Caption="$General.Edit$" Icon="Edit.png" />
            <ug:Action Name="delete" Caption="$General.Delete$" Icon="Delete.png" Confirmation="$General.ConfirmDelete$" />
        </GridActions>
        <GridColumns>
            <ug:Column Source="ReportSubscriptionEmail" Caption="$general.email$" Wrap="false">
                <Filter Type="text" />
            </ug:Column>
            <ug:Column Source="ReportSubscriptionSubject" Caption="$general.subject$" Wrap="false">
                <Filter Type="text" />
            </ug:Column>
            <ug:Column Source="ReportSubscriptionEnabled" Caption="$reportsubscription_enabled$"
                ExternalSourceName="enabled" Wrap="false">
                <Filter Type="bool" />
            </ug:Column>
            <ug:Column Width="100%" />
        </GridColumns>
        <GridOptions DisplayFilter="true" />
    </cms:UniGrid>
</asp:Content>
