<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_PortalEngine_Controls_Layout_PlaceholderMenu"
    CodeFile="PlaceholderMenu.ascx.cs" %>
<%@ Register TagPrefix="cms" Namespace="CMS.UIControls" Assembly="CMS.UIControls" %>
<cms:ContextMenu runat="server" ID="menuLayout" MenuID="layoutMenu" VerticalPosition="Bottom"
    HorizontalPosition="Left" OffsetX="25" ActiveItemCssClass="ItemSelected" MouseButton="Right"
    MenuLevel="1" ShowMenuOnMouseOver="true" Visible="false">
    <asp:Panel runat="server" ID="pnlSharedLayoutMenu" CssClass="PortalContextMenu PlaceholderContextMenu">
        <asp:Panel runat="server" ID="pnlSharedLayout" CssClass="ItemLast">
            <asp:Panel runat="server" ID="pnlSharedLayoutPadding" CssClass="ItemPadding">
                &nbsp;<asp:Label runat="server" ID="lblSharedLayoutVersions" CssClass="Name" EnableViewState="false"
                    Text="Shared layout versions" />
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</cms:ContextMenu>
<cms:ContextMenu runat="server" ID="menuTemplate" MenuID="templateMenu" VerticalPosition="Bottom"
    HorizontalPosition="Left" OffsetX="25" ActiveItemCssClass="ItemSelected" MouseButton="Right"
    MenuLevel="1" ShowMenuOnMouseOver="true" Visible="false">
    <asp:Panel runat="server" ID="pnlTemplateMenu" CssClass="PortalContextMenu PlaceholderContextMenu">
        <asp:Panel runat="server" ID="pnlTemplateVersions" CssClass="ItemLast">
            <asp:Panel runat="server" ID="pnlTemplateVersionsPadding" CssClass="ItemPadding">
                &nbsp;<asp:Label runat="server" ID="lblTemplateVersions" CssClass="Name" EnableViewState="false"
                    Text="Template versions" />
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</cms:ContextMenu>
<asp:Panel runat="server" ID="pnlPlaceholderMenu" CssClass="PortalContextMenu PlaceholderContextMenu">
    <cms:UIPlaceHolder ID="pnlUILayout" runat="server" ModuleName="CMS.Content" ElementName="Design.EditLayout">
        <cms:ContextMenuContainer runat="server" ID="cmcLayoutVersions" MenuID="layoutMenu">
            <cms:ContextMenuItem runat="server" ID="iLayout" />
        </cms:ContextMenuContainer>
    </cms:UIPlaceHolder>
    <cms:UIPlaceHolder ID="pnlUITemplate" runat="server" ModuleName="CMS.Content" ElementName="Design.EditTemplateProperties">
        <cms:ContextMenuContainer runat="server" ID="cmcTemplateVersions" MenuID="templateMenu">
            <cms:ContextMenuItem runat="server" ID="iTemplate" />
        </cms:ContextMenuContainer>
    </cms:UIPlaceHolder>
    <cms:UIPlaceHolder ID="pnlUIClone" runat="server" ModuleName="CMS.Content" ElementName="Design.CloneAdHoc">
        <cms:ContextMenuItem runat="server" ID="iClone" Last="true" />
    </cms:UIPlaceHolder>
    <cms:UIPlaceHolder ID="pnlUISaveAsNew" runat="server" ModuleName="CMS.Content" ElementName="Design.SaveAsNewTemplate">
        <cms:ContextMenuItem runat="server" ID="iSaveAsNew" Last="true" />
    </cms:UIPlaceHolder>
    <cms:UIPlaceHolder ID="plcUIWireframe" runat="server" ModuleName="CMS.Design" PermissionName="Wireframing">
        <cms:ContextMenuSeparator runat="server" ID="iSepWireframe" Visible="false" />
        <cms:ContextMenuItem runat="server" ID="iWireframe" />
    </cms:UIPlaceHolder>
    <cms:ContextMenuSeparator runat="server" ID="iSepRefresh" />
    <cms:ContextMenuItem runat="server" ID="iRefresh" Last="true" />
</asp:Panel>