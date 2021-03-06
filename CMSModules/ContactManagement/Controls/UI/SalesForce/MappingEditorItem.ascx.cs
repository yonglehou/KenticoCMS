﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

using CMS.ExtendedControls;
using CMS.FormEngine;
using CMS.GlobalHelper;
using CMS.SalesForce;

/// <summary>
/// Displays a mapping of Kentico object field to SalesForce entity attribute, and allows the user to edit it.
/// </summary>
public partial class CMSModules_ContactManagement_Controls_UI_SalesForce_MappingEditorItem : AbstractUserControl
{

    #region "Private members"

    private EntityModel mEntityModel;
    private EntityAttributeModel mEntityAttributeModel;
    private FormInfo mFormInfo;
    private AttributeValueConverterFactory mConverterFactory;
    private MappingItem mSourceMappingItem;

    #endregion

    #region "Public properties"

    /// <summary>
    /// Gets or sets the SalesForce entity model that is used in mapping.
    /// </summary>
    public EntityModel EntityModel
    {
        get
        {
            return mEntityModel;
        }
        set
        {
            mEntityModel = value;
        }
    }

    /// <summary>
    /// Gets or sets the SalesForce entity attribute model that is a target of mapping.
    /// </summary>
    public EntityAttributeModel EntityAttributeModel
    {
        get
        {
            return mEntityAttributeModel;
        }
        set
        {
            mEntityAttributeModel = value;
        }
    }

    /// <summary>
    /// Gets or sets the form info that is used in mapping.
    /// </summary>
    public FormInfo FormInfo
    {
        get
        {
            return mFormInfo;
        }
        set
        {
            mFormInfo = value;
        }
    }

    /// <summary>
    /// Gets or sets the initial mapping item.
    /// </summary>
    public MappingItem SourceMappingItem
    {
        get
        {
            return mSourceMappingItem;
        }
        set
        {
            mSourceMappingItem = value;
        }
    }

    /// <summary>
    /// Gets or sets the factory that creates instances of entity attribute value converters.
    /// </summary>
    public AttributeValueConverterFactory ConverterFactory
    {
        get
        {
            return mConverterFactory;
        }
        set
        {
            mConverterFactory = value;
        }
    }

    /// <summary>
    /// Gets the current mapping item.
    /// </summary>
    public MappingItem MappingItem
    {
        get
        {
            return GetMappingItem();
        }
    }

    #endregion

    #region "Life-cycle methods"

    protected override void OnPreRender(EventArgs e)
    {
        if (SourceDropDownList.Items.Count == 0)
        {
            string message = GetString("sf.noattributemappingavailable");
            if (EntityAttributeModel.HasDefaultValue)
            {
                message = GetString("sf.noattributemappingavailabledefault");
            }
            else
            {
                EmptyMessageControl.Attributes.Add("class", "Red");
                AppendError(message);
            }
            EmptyMessageControl.InnerHtml = HTMLHelper.HTMLEncode(message);
            SourceDropDownList.Visible = false;
        }
        else
        {
            EmptyMessageControl.Visible = false;
        }
        base.OnPreRender(e);
    }

    #endregion

    #region "Public methods"

    /// <summary>
    /// Initializes this instance of mapping editor item.
    /// </summary>
    public void Initialize()
    {
        if (EntityAttributeModel.IsNullable || EntityAttributeModel.HasDefaultValue)
        {
            SourceDropDownList.Items.Add(new ListItem());
        }
        InitializeFields();
        InitializeMetaFields();
        InitializePicklistEntries();
        ChooseDefaultSource();
        AttributeLabel.Text = HTMLHelper.HTMLEncode(EntityAttributeModel.Label);
        AttributeLabel.ToolTip = EntityAttributeModel.HelpText;
    }

    #endregion

    #region "Private methods"

    private void InitializeFields()
    {
        foreach (FormFieldInfo fieldInfo in FormInfo.ItemsList)
        {
            AttributeValueConverterBase converter = ConverterFactory.CreateAttributeValueConverter(EntityAttributeModel, fieldInfo);
            if (converter != null)
            {
                string name = String.Format("Field-{0}", fieldInfo.Name);
                ListItem item = new ListItem
                {
                    Text = ResHelper.LocalizeString(fieldInfo.Caption),
                    Value = name
                };
                SourceDropDownList.Items.Add(item);
                AppendCompatibilityWarnings(name, converter.GetCompatibilityWarnings());
            }
        }
    }

    private void InitializeMetaFields()
    {
        if (EntityAttributeModel.Type == EntityAttributeValueType.String || EntityAttributeModel.Type == EntityAttributeValueType.Textarea)
        {
            ListItem companyNameItem = new ListItem
            {
                Text = GetString("sf.metasource.companyname"),
                Value = "MetaField-CompanyName"
            };
            SourceDropDownList.Items.Add(companyNameItem);
            ListItem descriptionItem = new ListItem
            {
                Text = GetString("sf.metasource.description"),
                Value = "MetaField-Description"
            };
            SourceDropDownList.Items.Add(descriptionItem);
            ListItem countryItem = new ListItem
            {
                Text = GetString("sf.metasource.country"),
                Value = "MetaField-Country"
            };
            SourceDropDownList.Items.Add(countryItem);
            ListItem stateItem = new ListItem
            {
                Text = GetString("sf.metasource.state"),
                Value = "MetaField-State"
            };
            SourceDropDownList.Items.Add(stateItem);
        }
    }

    private void InitializePicklistEntries()
    {
        if (EntityAttributeModel.Type == EntityAttributeValueType.Picklist || EntityAttributeModel.Type == EntityAttributeValueType.MultiPicklist)
        {
            foreach (PicklistEntry entry in EntityAttributeModel.PicklistEntries.Where(x => x.IsActive))
            {
                ListItem item = new ListItem
                {
                    Text = entry.Label,
                    Value = String.Format("PicklistEntry-{0}", entry.Value)
                };
                SourceDropDownList.Items.Add(item);
            }
        }
    }

    private void ChooseDefaultSource()
    {
        if (SourceMappingItem != null)
        {
            switch (SourceMappingItem.SourceType)
            {
                case MappingItemSourceTypeEnum.Field :
                    SourceDropDownList.SelectedValue = String.Format("Field-{0}", SourceMappingItem.SourceName);
                    break;
                case MappingItemSourceTypeEnum.MetaField :
                    SourceDropDownList.SelectedValue = String.Format("MetaField-{0}", SourceMappingItem.SourceName);
                    break;
                case MappingItemSourceTypeEnum.PicklistEntry:
                    SourceDropDownList.SelectedValue = String.Format("PicklistEntry-{0}", SourceMappingItem.SourceName);
                    break;
            }
        }
        if (String.IsNullOrEmpty(SourceDropDownList.SelectedValue))
        {
            if (EntityAttributeModel.Type == EntityAttributeValueType.Picklist || EntityAttributeModel.Type == EntityAttributeValueType.MultiPicklist)
            {
                PicklistEntry defaultEntry = EntityAttributeModel.PicklistEntries.FirstOrDefault(x => x.IsActive && x.IsDefault);
                if (defaultEntry != null)
                {
                    SourceDropDownList.SelectedValue = String.Format("PicklistEntry-{0}", defaultEntry.Value);
                }
            }
        }
    }

    private void AppendCompatibilityWarnings(string name, IList<string> warnings)
    {
        if (warnings.Count > 0)
        {
            Image image = new Image
            {
                ToolTip = GetCompatibilityWarningsHtml(name, warnings),
                ImageUrl = GetImageUrl("CMSModules/CMS_ContactManagement/collision.png"),
                CssClass = String.Format("Warning{0}", name)
            };
            ScriptHelper.AppendTooltip(image, image.ToolTip, "help");
            image.Style.Add("cursor", "help");
            image.Style.Add("display", "none");
            WarningPlaceHolder.Controls.Add(image);
        }
    }

    private void AppendError(string message)
    {
        Image image = new Image
        {
            ToolTip = message,
            ImageUrl = GetImageUrl("CMSModules/CMS_ContactManagement/error.gif")
        };
        ScriptHelper.AppendTooltip(image, image.ToolTip, "help");
        image.Style.Add("cursor", "help");
        WarningPlaceHolder.Controls.Add(image);
    }

    private string GetCompatibilityWarningsHtml(string name, IList<string> warnings)
    {
        StringBuilder builder = new StringBuilder();
        builder.Append("<ul>");
        foreach (string warning in warnings)
        {
            builder.Append("<li>");
            builder.Append(HTMLHelper.HTMLEncode(warning));
            builder.Append("</li>");
        }
        builder.Append("</ul>");
        return builder.ToString();
    }

    private MappingItem GetMappingItem()
    {
        string name = SourceDropDownList.SelectedValue;
        if (!String.IsNullOrEmpty(name))
        {
            if (name.StartsWith("Field-"))
            {
                name = name.Remove(0, "Field-".Length);
                FormFieldInfo fieldInfo = FormInfo.GetFormField(name);
                if (fieldInfo != null)
                {
                    return new MappingItem(EntityAttributeModel, name, ResHelper.LocalizeString(fieldInfo.Caption), MappingItemSourceTypeEnum.Field);
                }
            }
            else if (name.StartsWith("MetaField-"))
            {
                name = name.Remove(0, "MetaField-".Length);
                switch (name)
                {
                    case "CompanyName":
                        return new MappingItem(EntityAttributeModel, name, GetString("sf.metasource.companyname"), MappingItemSourceTypeEnum.MetaField);
                    case "Description":
                        return new MappingItem(EntityAttributeModel, name, GetString("sf.metasource.description"), MappingItemSourceTypeEnum.MetaField);
                    case "Country":
                        return new MappingItem(EntityAttributeModel, name, GetString("sf.metasource.country"), MappingItemSourceTypeEnum.MetaField);
                    case "State":
                        return new MappingItem(EntityAttributeModel, name, GetString("sf.metasource.state"), MappingItemSourceTypeEnum.MetaField);
                }
            }
            else if (name.StartsWith("PicklistEntry-"))
            {
                name = name.Remove(0, "PicklistEntry-".Length);
                PicklistEntry entry = EntityAttributeModel.PicklistEntries.SingleOrDefault(x => x.IsActive && x.Value == name);
                if (entry != null)
                {
                    return new MappingItem(EntityAttributeModel, name, entry.Label, MappingItemSourceTypeEnum.PicklistEntry);
                }
            }
        }

        return null;
    }

    #endregion

}