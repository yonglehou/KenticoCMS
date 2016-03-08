<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_Newsletters_Tools_Templates_Tab_Newsletters"
    Theme="Default" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Title="Newsletter template edit - Newsletters"
    CodeFile="Tab_Newsletters.aspx.cs" %>

<%@ Register Src="~/CMSAdminControls/UI/UniSelector/UniSelector.ascx" TagName="UniSelector"
    TagPrefix="cms" %>
<asp:Content ID="cntBody" runat="server" ContentPlaceHolderID="plcContent">
    <strong>
        <cms:LocalizedLabel runat="server" ID="lblAssigned" ResourceString="newslettertemplate.pernewslettertemplate"
            DisplayColon="true" CssClass="InfoLabel" />
    </strong>
    <cms:CMSUpdatePanel runat="server" ID="pnlAvailability">
        <ContentTemplate>
            <cms:UniSelector ID="usNewsletters" runat="server" IsLiveSite="false" ObjectType="Newsletter.Newsletter"
                SelectionMode="Multiple" ResourcePrefix="newsletterselect" />
        </ContentTemplate>
    </cms:CMSUpdatePanel>
</asp:Content>