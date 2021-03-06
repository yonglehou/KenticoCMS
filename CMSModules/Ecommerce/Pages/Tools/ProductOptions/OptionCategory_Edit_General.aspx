<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_Ecommerce_Pages_Tools_ProductOptions_OptionCategory_Edit_General"
    Theme="Default" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Title="Option Category - Edit"
    CodeFile="OptionCategory_Edit_General.aspx.cs" %>

<%@ Register Src="~/CMSFormControls/System/LocalizableTextBox.ascx" TagName="LocalizableTextBox"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ProductOptionSelector.ascx"
    TagName="ProductOptionSelector" TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/FormControls/FormControls/FormControlSelector.ascx"
    TagName="FormControlSelector" TagPrefix="cms" %>
<%@ Register Src="~/CMSAdminControls/UI/UniSelector/UniSelector.ascx" TagName="UniSelector"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSFormControls/System/CodeName.ascx" TagName="CodeName" TagPrefix="cms" %>
<asp:Content ID="cntBody" runat="server" ContentPlaceHolderID="plcContent">
    <table style="vertical-align: top;">
        <tr>
            <td class="FieldLabel">
                <cms:LocalizedLabel runat="server" ID="lblDisplayName" EnableViewState="false" ResourceString="general.displayname"
                    DisplayColon="true" />
            </td>
            <td>
                <cms:LocalizableTextBox ID="txtDisplayName" runat="server" CssClass="TextBoxField"
                    MaxLength="200" EnableViewState="false" />
                <cms:CMSRequiredFieldValidator ID="rfvDisplayName" ControlToValidate="txtDisplayName:textbox"
                    runat="server" Display="Dynamic" ValidationGroup="OptionCategories" EnableViewState="false" />
            </td>
        </tr>
        <tr>
            <td class="FieldLabel">
                <asp:Label runat="server" ID="lblCategoryName" EnableViewState="false" />
            </td>
            <td>
                <cms:CodeName ID="txtCategoryName" runat="server" CssClass="TextBoxField" MaxLength="200"
                    EnableViewState="false" />
                <cms:CMSRequiredFieldValidator ID="rfvCategoryName" ControlToValidate="txtCategoryName"
                    runat="server" Display="Dynamic" ValidationGroup="OptionCategories" EnableViewState="false" />
            </td>
        </tr>
        <tr>
            <td class="FieldLabel">
                <asp:Label runat="server" ID="lblCategorySelectionType" EnableViewState="false" />
            </td>
            <td>
                <cms:CMSUpdatePanel ID="pnlAjax" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="drpCategorySelectionType" runat="server" CssClass="DropDownField"
                            AutoPostBack="true" OnSelectedIndexChanged="drpCategorySelectionType_SelectedIndexChanged" />
                    </ContentTemplate>
                </cms:CMSUpdatePanel>
            </td>
        </tr>
        <tr>
            <td class="FieldLabel">
                <cms:LocalizedLabel ID="lblCategoryDisplayPrice" runat="server" DisplayColon="true"
                    ResourceString="OptionCategory_Edit.CategoryDisplayPrice" EnableViewState="false" />
            </td>
            <td>
                <cms:CMSUpdatePanel ID="pnlUpdateCategoryDisplayPrice" runat="server">
                    <ContentTemplate>
                        <asp:CheckBox ID="chkCategoryDisplayPrice" AutoPostBack="true" OnCheckedChanged="chkCategoryDisplayPrice_CheckedChanged"
                            runat="server" CssClass="CheckBoxMovedLeft" />
                    </ContentTemplate>
                </cms:CMSUpdatePanel>
            </td>
        </tr>
        <%--Default options--%>
        <tr>
            <td class="FieldLabel" style="vertical-align: top;">
                <asp:Label runat="server" ID="lblCategoryDefaultOptions" EnableViewState="false" />
            </td>
            <td style="vertical-align: top;">
                <cms:CMSUpdatePanel runat="server">
                    <ContentTemplate>
                        <cms:CMSPanel ID="pnlDefaultOptions" runat="server" ShortID="pdo" CssClass="TextBoxField">
                            <cms:CMSPanel ID="pnlDefaultOptionsBorder" runat="server" ShortID="pdob" CssClass="TextBoxField">
                                <cms:ProductOptionSelector ID="productOptionSelector" runat="server" ShowOptionCategoryName="false"
                                    ShowOptionCategoryDescription="false" />
                            </cms:CMSPanel>
                        </cms:CMSPanel>
                    </ContentTemplate>
                </cms:CMSUpdatePanel>
                <asp:Label runat="server" ID="lblNoOptions" EnableViewState="false" Visible="false" />
            </td>
        </tr>
        <asp:PlaceHolder runat="server" ID="plcTextMaxLength">
            <tr>
                <td class="FieldLabel">
                    <asp:Label runat="server" ID="lblTextMaxLength" EnableViewState="false" />
                </td>
                <td>
                    <asp:TextBox ID="txtTextMaxLength" runat="server" CssClass="TextBoxField" EnableViewState="false"
                        MaxLength="9" />
                </td>
            </tr>
        </asp:PlaceHolder>
        <tr>
            <td class="FieldLabel" style="vertical-align: top;">
                <asp:Label runat="server" ID="lblCategoryDescription" EnableViewState="false" />
            </td>
            <td>
                <cms:LocalizableTextBox ID="txtCategoryDecription" runat="server" CssClass="TextAreaField"
                    TextMode="MultiLine" EnableViewState="false" />
            </td>
        </tr>
        <asp:PlaceHolder runat="server" ID="plcDefaultRecordText">
            <tr>
                <td class="FieldLabel">
                    <asp:Label runat="server" ID="lblDefaultRecord" EnableViewState="false" />
                </td>
                <td>
                    <cms:LocalizableTextBox ID="txtDefaultRecord" runat="server" CssClass="TextBoxField"
                        EnableViewState="false" />
                </td>
            </tr>
        </asp:PlaceHolder>
        <tr>
            <td class="FieldLabel">
                <cms:LocalizedLabel runat="server" ID="lblCategoryEnabled" EnableViewState="false"
                    ResourceString="general.enabled" DisplayColon="true" />
            </td>
            <td>
                <asp:CheckBox ID="chkCategoryEnabled" runat="server" Checked="true" CssClass="CheckBoxMovedLeft"
                    EnableViewState="false" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <cms:FormSubmitButton runat="server" ID="btnOk" OnClick="btnOK_Click" EnableViewState="false"
                    ValidationGroup="OptionCategories" />
            </td>
        </tr>
    </table>
</asp:Content>
