<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_Membership_Pages_Roles_Role_Edit_General"
    Theme="Default" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Title="Role Edit - General"
    CodeFile="Role_Edit_General.aspx.cs" %>

<%@ Register Src="~/CMSModules/Membership/Controls/Roles/RoleEdit.ascx" TagName="RoleEdit"
    TagPrefix="cms" %>
<asp:Content ID="cntBody" runat="server" ContentPlaceHolderID="plcContent">
    <cms:RoleEdit ID="roleEditElem" runat="server" IsLiveSite="False" />
</asp:Content>