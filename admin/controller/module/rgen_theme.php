<?php
class ControllerModuleRgenTheme extends Controller {
	private $error = array(); 
	public function index() {   
		
		$this->language->load('module/rgen_theme');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		$this->load->model('tool/image');
		
		// COLOUR PICKER FILES
		$this->document->addStyle('view/stylesheet/jquery.colorpicker.css');
		$this->document->addScript('view/javascript/jquery/jquery.colorpicker.js');
		
		$this->data['mod'] = $this->language->get('mod');
		$this->data['ver'] = $this->language->get('ver');
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		$this->data['tab_module'] = $this->language->get('tab_module');
		
		$this->data['token'] = $this->session->data['token'];
		
		// BODY BACKGROUND IMAGE
		$BodyBgImg = 'RGen_bodyBgImg';
		if (isset($this->request->post[$BodyBgImg])) {
			$this->data[$BodyBgImg] = $this->request->post[$BodyBgImg];
			$RGen_bodyBgImg = $this->request->post[$BodyBgImg];
		} else {
			$this->data[$BodyBgImg] = '';
		}
		
		// HEADER BACKGROUND IMAGE
		$HeaderBgImg = 'RGen_headerBgImg';
		if (isset($this->request->post[$HeaderBgImg])) {
			$this->data[$HeaderBgImg] = $this->request->post[$HeaderBgImg];
			$RGen_headerBgImg = $this->request->post[$HeaderBgImg];
		} else {
			$this->data[$HeaderBgImg] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('rgen_theme', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/rgen_theme', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/rgen_theme', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		// CUSTOM FOOTER ARRAY
        $RGen_FT_data = array(
		
			// GENERAL SETTINGS
			'RGen_reaponsive_status',
			'RGen_prdList_defaultView',
            'RGen_refineCate_View',
            'RGen_refineCate_layout',
            'RGen_carouselArrow',
            'RGen_colprdView_special',
            'RGen_colprdView_latest',
            'RGen_colprdView_featured',
            'RGen_colprdView_best',
            'RGen_prdBlock_view',
            'RGen_modPrdBlock_special',
            'RGen_modPrdBlock_latest',
            'RGen_modPrdBlock_featured',
            'RGen_modPrdBlock_best',
            'RGen_layout',
            'RGen_menulayout',
            'RGen_scrollTop_status',
            'RGen_menuhome',

			
			// CUSTOM FONT SETTINGS
			'RGen_fontSettings_status',
			'RGen_Body_font',
			'RGen_Body_font_size',
			'RGen_Body_font_weight',
			'RGen_PageTitle_font',
			'RGen_PageTitle_font_size',
			'RGen_PageTitle_font_weight',
			'RGen_PageTitle_transform',
			'RGen_otherHeading_font',
			'RGen_otherHeading_font_weight',
			'RGen_otherHeading_transform',
			'RGen_Navigation_font',
			'RGen_Navigation_font_size',
			'RGen_Navigation_font_weight',
			'RGen_Navigation_transform',
			'RGen_Price_font_weight',
			'RGen_Price_font',
			'RGen_Button_font',
			'RGen_Button_font_weight',
			'RGen_Button_font_transform',
			'RGen_other_font',
			'RGen_other_font_weight',
			'RGen_other_font_transform',

			'RGen_capHeading_font',
			'RGen_capHeading_font_size',
			'RGen_capHeading_font_weight',
			'RGen_capHeading_font_transform',

			'RGen_capLink_font',
			'RGen_capLink_font_size',
			'RGen_capLink_font_weight',
			'RGen_capLink_font_transform',

			'RGen_capContent_font',
			'RGen_capContent_font_size',
			'RGen_capContent_font_weight',
			'RGen_capContent_font_transform',


			
			// PRDOUCT PAGE SETTINGS
			'RGen_productZoom',
			'RGen_reviewTab',
			'RGen_thumbOptions',
			'RGen_productLayout',
			
			
			// MENU SETTINGS
			'RGen_menu_AllCategory',
			'RGen_customMenu_status',
			'RGen_menu1_item',	'RGen_menu1_item_url',
				'RGen_subMenu1_item1',	'RGen_subMenu1_item2',	'RGen_subMenu1_item3',
				'RGen_subMenu1_item4',	'RGen_subMenu1_item5',	'RGen_subMenu1_item6',
				'RGen_subMenu1_item7',	'RGen_subMenu1_item8',	'RGen_subMenu1_item9',
				'RGen_subMenu1_item10',	
				
				'RGen_subMenu1_item_url1',	'RGen_subMenu1_item_url2',	'RGen_subMenu1_item_url3',
				'RGen_subMenu1_item_url4',	'RGen_subMenu1_item_url5',	'RGen_subMenu1_item_url6',
				'RGen_subMenu1_item_url7',	'RGen_subMenu1_item_url8',	'RGen_subMenu1_item_url9',
				'RGen_subMenu1_item_url10',
				
			'RGen_menu_item_status',
				'RGen_menu_item1',	'RGen_menu_item2',	'RGen_menu_item3',
				'RGen_menu_item4',	'RGen_menu_item5',
				'RGen_menu_item1_url',	'RGen_menu_item2_url',	'RGen_menu_item3_url',
				'RGen_menu_item4_url',	'RGen_menu_item5_url',
				
			'RGen_informationMenu_status',
			'RGen_multiLevelMenu_status',
			'RGen_MenuItemSpace',
			'RGen_menuhtml_status',
			'RGen_myac_status',
			
			
			// LOGO SETTINGS 
			'RGen_logoPosition_status',
			'RGen_logoLeft',
			'RGen_logoTop',
			'RGen_logoBG_color',
			'RGen_logoSpaceAround_LR',
			'RGen_logoSpaceAround_TB',
			
			'RGen_FT_Status',
			'RGen_FT_Status_home',
			
			'RGen_FT_about_Status',
			'FT_about_Title',
			'FT_about_Text',
			
			'RGen_FT_twitter_Status',
			'FT_twitter_Title',
			'FT_twitter_Tweets',
			'FT_twitter_User',
			'FT_twitter_widgetid',
			'FT_twitter_theme',
			'FT_twitter_linkcolor',
						
			'RGen_FT_fb_Status',
			'FT_fb_Title',
			'FT_fb_ID',
			
			// FOOTER SOCIAL LINKS
			'socialLink_fb_Status',
			'socialLink_fb',
			'socialLink_twitter_Status',
			'socialLink_twitter',
			'socialLink_youtube_Status',
			'socialLink_youtube',
			'socialLink_google_Status',
			'socialLink_google',
			'socialLink_flickr_Status',
			'socialLink_flickr',
			'socialLink_pintrest_Status',
			'socialLink_pintrest',
			'socialLink_rss_Status',
			'socialLink_rss',
			'socialLink_yahoo_Status',
			'socialLink_yahoo',
			'socialLink_thumblr_Status',
			'socialLink_thumblr',
			'socialLink_insta_Status',
			'socialLink_insta',
			'socialLink_linkedin_Status',
			'socialLink_linkedin',
			'socialLink_vimeo_Status',
			'socialLink_vimeo',
			'socialLink_mailTo_Status',
			'socialLink_mailTo',
			'socialLink_addThis_Status',
			'socialLink_addThis',
			
			'copyrightText',
			
			// FOOTER CONTACT US
			'FT_Contact_status',
			'FT_Contact_phStatus',
			'FT_Contact_ph',
			'FT_Contact_ph1',
			'FT_Contact_faxStatus',
			'FT_Contact_fax',
			'FT_Contact_fax1',
			'FT_Contact_emailStatus',
			'FT_Contact_email',
			
			// READY TO USE THEME
			'RGen_theme',
			'RGen_theme_option',
			'RGen_theme_optionStatus',
			
			// GENERAL THEME COLORS
			'RGen_Icons',
			'RGen_bodyBg',
			'RGen_bodyBgImg',
			'RGen_bodyBgImg_preview',
			'RGen_bodyBgImgRepeat',
			'RGen_bodyBgImgPosition',
			'RGen_globalLines',
			'RGen_globalColour',
			'RGen_globalColourRing',
			'RGen_pageBg',
			'RGen_pageShadow',
			'RGen_ImageBox',
			'RGen_fontColor',
			'RGen_bodyBgAttachment',
			'RGen_scrollTop',
			'RGen_scrollTop_arrow',

			// CUSTOM BLOCK TOP HEADER
			'RGen_custTP_bg',
			'RGen_custTP_hd',
			'RGen_custTP_border',
			'RGen_custTP_content',
			'RGen_custTP_arrowBg',
			'RGen_custTP_arrow',

			// CUSTOM BLOCK FOOTER
			'RGen_custFT_bg',
			'RGen_custFT_hd',
			'RGen_custFT_border',
			'RGen_custFT_content',
			'RGen_custFT_arrowBg',
			'RGen_custFT_arrow',
			
			// BUTTONS AND FORMS
			'RGen_btColor',
			'RGen_btColor_hover',
			'RGen_btFontColor',
			'RGen_btFontColor_hover',
			'RGen_btColor1',
			'RGen_btColor1_hover',
			'RGen_btFontColor1',
			'RGen_btFontColor1_hover',
			'RGen_LinkColor',
			'RGen_LinkColor_hover',
			'RGen_LinkBtColor',
			'RGen_LinkBtFontColor',
			'RGen_LinkBtColor_hover',
			'RGen_LinkBtFontColor_hover',
			'RGen_TextBox',
			'RGen_TextBoxBorder',
			'RGen_TextBoxText',
			'RGen_FormLabel',
			'RGen_FormBorders',
			'RGen_FormHeaders',
			
			'RGen_arrow',
			'RGen_arrow_hover',
			'RGen_arrowBg',
			'RGen_arrowBg_hover',
			'RGen_arrowBgRing',
			'RGen_arrowBgRing_hover',
			
			'RGen_Header',
			
			'RGen_tableListHeader',
			'RGen_tableListHeaderFont',
			'RGen_tableListFont',
			'RGen_tableListBorder_right',
			'RGen_tableListBorder_bottom',

			// SLIDESHOW
			'RGen_ssBg',
			'RGen_c1_hdBg',
			'RGen_c1_hdText',
			'RGen_c1_dataBg',
			'RGen_c1_dataText',
			'RGen_c1_linkBg',
			'RGen_c1_linkBg',
			'RGen_c1_linkText',

			'RGen_c2_hdText',
			'RGen_c2_hdTextshd',
			'RGen_c2_dataText',
			'RGen_c2_dataTextshd',
			'RGen_c2_dataBdr',
			'RGen_c2_linkBg',
			'RGen_c2_linkText',
			'RGen_c2_linkBdr',
			'RGen_c2_linkBg_hover',
			'RGen_c2_linkText_hover',
			'RGen_c2_linkBdr_hover',

			'RGen_c3_Bg',
			'RGen_c3_hdText',
			'RGen_c3_dataText',
			'RGen_c3_dataBdr',
			'RGen_c3_linkBg',
			'RGen_c3_linkText',
			'RGen_c3_linkBg_hover',
			'RGen_c3_linkText_hover',
			'RGen_c3_linkBdr_hover',

			'RGen_c4_hdBg',
			'RGen_c4_hdText',
			'RGen_c4_dataText',
			'RGen_c4_linkBg',
			'RGen_c4_linkText',
			'RGen_c4_link_hover',

			'RGen_c5_Bg',
			'RGen_c5_hdText',
			'RGen_c5_dataText',
			'RGen_c5_dataBdr',
			'RGen_c5_linkBg',
			'RGen_c5_linkText',
			'RGen_c5_linkBg_hover',
			'RGen_c5_linkText_hover',
			'RGen_c5_linkBdr_hover',

			'RGen_c6_hdText',
			'RGen_c6_dataText',
			'RGen_c6_linkBg',
			'RGen_c6_linkText',
			'RGen_c6_linkBg_hover',
			'RGen_c6_link_hover',
			'RGen_c6_linkBdr_hover',
			
			// HEADER SECTION
			'RGen_headerBg',
			'RGen_headerBgImg',
			'RGen_headerBgImg_preview',
			'RGen_headerBgImgRepeat',
			'RGen_headerBgImgPosition',
			'RGen_Breadcrumb_Link',
			'RGen_Breadcrumb_Link_hover',
			'RGen_Breadcrumb_Arrow',
			'RGen_Logo',
			'RGen_Header_text',
			'RGen_Header_Link',
			'RGen_Header_Link_hover',
			
			// MENU 
			'RGen_Navbar',
			'RGen_NavMenubar',
			'RGen_Nav',
			'RGen_Nav_hover',
			'RGen_NavFont',
			'RGen_NavFont_hover',
			'RGen_NavSub_bg',
			'RGen_NavSub',
			'RGen_NavSub_hover',
			'RGen_NavSubFont',
			'RGen_NavSubFont_hover',
			'RGen_NavSubBorder',
			'RGen_homeBt',
			'RGen_homeBtRing',
			'RGen_homeBt_hover',
			'RGen_homeBtIcon',
			'RGen_homeBtIcon_hover',
			
			// SEARCH
			'RGen_searchBtIcon',
			'RGen_searchBtIcon_hover',
			'RGen_searchBg',
			'RGen_searchOuterBg',
			'RGen_searchText',
			'RGen_searchBt',
			'RGen_searchBtRing',
			'RGen_searchBt_hover',
			'RGen_searchBtRing_hover',
			
			// CURRENCY AND LANGUAGE
			'RGen_CurLanBg',
			'RGen_CurLanDropdown',
			'RGen_CurLanDropdown_hover',
			'RGen_CurLanText',
			'RGen_CurLanText_hover',
			'RGen_CurLanArrow',
			'RGen_CurLanSelected',
			
			// HEADER MINI CART
			'RGen_MiniCart',
			'RGen_MiniCartText',
			'RGen_MiniCartIcon',
			'RGen_MiniCartContent',
			'RGen_MiniCartContent_border',
			'RGen_MiniCartContent_text',
			'RGen_MiniCartContent_image',
			'RGen_MiniCartContent_links',
			'RGen_MiniCartContent_total',
			'RGen_MiniCartContent_label',
			'RGen_MiniCartContent_value',

			// PRODUCT BOX 3 COLORS
			"RGen_prd3_bg",
			"RGen_prd3_bg_hover",
			"RGen_prd3_bdr_w",
			"RGen_prd3_bdr_w_hover",
			"RGen_prd3_bdr",
			"RGen_prd3_bdr_hover",
			"RGen_prd3_name",
			"RGen_prd3_name_hover",
			"RGen_prd3_priceOld",
			"RGen_prd3_priceNew",
			"RGen_prd3_cartText",
			"RGen_prd3_cartText_hover",
			"RGen_prd3_cartBg",
			"RGen_prd3_cartBg_hover",
			"RGen_prd3_prdbtIcon",
			"RGen_prd3_prdbtIcon_hover",
			"RGen_prd3_prdbtBdr",
			"RGen_prd3_prdbtBdr_hover",
			"RGen_prd3_prdbtBg",
			"RGen_prd3_prdbtBg_hover",
			"RGen_prd3_rating",

			// PRODUCT BOX 2 COLORS
			'RGen_prd2_image',
			'RGen_prd2_name',
			'RGen_prd2_priceOld',
			'RGen_prd2_priceNew',
			'RGen_prd2_priceTax',
			'RGen_prd2_link',
			'RGen_prd2_link_hover',
			'RGen_prd2_cartbt',
			'RGen_prd2_cartbt_bg',
			'RGen_prd2_cartbt_hover',
			'RGen_prd2_cartbt_bg_hover',
			'RGen_prd2_cartbt_bdr',
			'RGen_prd2_cartbt_bdr_hover',

			// PRODUCT BOX 1 COLORS
			'RGen_RefinCateHdBg',
			'RGen_RefinCateHdFontColor',
			'RGen_RefinCateBg',
			'RGen_RefinCateFontColour',
			'RGen_prdBack',
			'RGen_prdName',
			'RGen_prdLinks',
			'RGen_prdLinks_hover',
			'RGen_prdText',
			'RGen_prdHover_Bg',
			'RGen_PriceBg',
			'RGen_Price',
			'RGen_OldPrice',
			'RGen_PriceRing',
			'RGen_cartBt',
			'RGen_cartBtRing',
			'RGen_cartBt_hover',
			'RGen_cartBtRing_hover',
			'RGen_cartBtIcon',
			'RGen_cartBtIcon_hover',
			'RGen_prdBorder',
			
			'RGen_capStatus',
			'RGen_cap',

			// HOME PAGE MAIN BANNER FEATURE PRODUCT MODULE
			'RGen_bannerPosition',
			'RGen_SlideShow_Mod_status',
			'RGen_SlideShow_Mod',
			'RGen_SlideShow_Type',
			'RGen_featuredTitleBg',
			'RGen_featuredTitleFont',
			'RGen_featuredBg',
			'RGen_featuredHover_Bg',
			'RGen_featuredPrdText',
			'RGen_featuredArrow',
			'RGen_featuredArrow_hover',
			
			'RGen_featuredPrdLines',
			'RGen_featuredArrowIcon',
			'RGen_featuredArrowIcon_hover',
			'RGen_Slideshow_pager',
			'RGen_Slideshow_pagerActive',
			'RGen_featuredArrowIcon',
			
			'RGen_featuredPriceBg',
			'RGen_featuredPrice',
			'RGen_featuredPriceOld',
			'RGen_featuredCrtBtIcon',
			'RGen_featuredCrtBtIcon_hover',
			'RGen_featuredCrtBt',
			'RGen_featuredCrtBt_hover',
			'RGen_featuredCrtBtRing',
			'RGen_featuredCrtBtRing_hover',
			
			// PRODUCT PAGE
			'RGen_prdImageBg',
			'RGen_prdImageActive',
			'RGen_prdZoomText',
			'RGen_prdZoomIcon',
			'RGen_prdPriceBg',
			'RGen_prdPriceRing',
			'RGen_prdPriceOld',
			'RGen_prdPriceNew',
			'RGen_prdPriceTax',
			'RGen_prdDiscount_border',
			'RGen_prdOtherText',
			'RGen_prdQty',
			'RGen_prdQtyBorder',
			'RGen_prdQtyText',
			'RGen_prdCartBt',
			'RGen_prdCartBt_hover',
			'RGen_prdCartRing',
			'RGen_prdCartRing_hover',
			'RGen_prdCartIcon',
			'RGen_prdCartIcon_hover',
			'RGen_prdOptionLabel',
			'RGen_TabsBg',
			'RGen_TabsNormal',
			'RGen_TabText',
			'RGen_TabActiveText',
			'RGen_TabContentText',
			'RGen_WriteReview',
			'RGen_WriteReview_label',
			'RGen_WriteReview_Rating',
			'RGen_WriteReview_RatingBdr',
			'RGen_WriteReviewRating_bg',
			'RGen_WriteReviewRating_Text',
			
			// SLIDE SHOW SETTINGS
			'RGen_slideshow_Effect',
			'RGen_slideshow_animSpeed',
			'RGen_slideshow_pauseTime',
			'RGen_slideshow_startSlide',
			'RGen_slideshow_directionNav',
			'RGen_slideshow_controlNav',
			'RGen_slideshow_pauseOnHover',
			
			// FOOTER
			'RGen_FooterWrpBg',
			'RGen_FooterHeader',
			'RGen_FooterText',
			'RGen_FooterLinks',
			'RGen_FooterLinks_hover',
			'RGen_FooterBg',
			'RGen_FooterLines',
			'RGen_FooterSocial',
			'RGen_FooterSocialIcon',
			'RGen_FooterSocialIcon_hover',
			'RGen_FooterSocial_bdr',
			'RGen_FooterSocialRing',
			'RGen_FooterSocial_hover',
			'RGen_FooterSocialRing_hover',
			'RGen_contactIcons',
			'RGen_contactText',
			'RGen_contactIcon_color',
			'RGen_twitterIcon_color',
			'RGen_fbtheme',

			
			// CUSTOM CSS
			'RGen_CustomCSS_Status',
			'RGen_CustomJS_Status',
			'RGen_customFile_Status',
			'RGen_CustomCSS_file',
			'RGen_CustomCSS',
			'RGen_CustomJS'
			
			
		);

        foreach ($RGen_FT_data as $RGen_FT_val) {
            if (isset($this->request->post[$RGen_FT_val])) {
                $this->data[$RGen_FT_val] = $this->request->post[$RGen_FT_val];
            } else {
                $this->data[$RGen_FT_val] = $this->config->get($RGen_FT_val);
			}
		}
		
		$this->data['RGen'] = array();
		if (isset($this->request->post['RGen_module'])) {
			$this->data['RGen'] = $this->request->post['RGen_module'];
		} elseif ($this->config->get('RGen_module')) { 
			$this->data['RGen'] = $this->config->get('RGen_module');
		}
		
		$this->data['RGenData'] = array();
		if (isset($this->request->post['RGenData_mod'])) {
			$this->data['RGenData'] = $this->request->post['RGenData_mod'];
		} elseif ($this->config->get('RGenData_mod')) { 
			$this->data['RGenData'] = $this->config->get('RGenData_mod');
		}
		

		$this->data['checkPermission'] = $this->user->hasPermission('modify', 'module/rgen_theme');
			
		$this->data['text_image_manager'] = 'Image manager';
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$getLayouts = $this->data['layouts'];
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->template = 'module/rgen_theme.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		// BODY BG IMAGE PREVIEW
		$BodyBgImg_Preview = 'RGen_bodyBgImg_preview';
		if (isset($this->data[$BodyBgImg]) && $this->data[$BodyBgImg] != "" && file_exists(DIR_IMAGE . $this->data[$BodyBgImg])) {
			$this->data[$BodyBgImg_Preview] = $this->model_tool_image->resize($this->data[$BodyBgImg], 100, 100);
		} else {
			$this->data[$BodyBgImg_Preview] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}
		
		// HEADER IMAGE PREVIEW
		$HeaderBgImg_Preview = 'RGen_headerBgImg_preview';
		if (isset($this->data[$HeaderBgImg]) && $this->data[$HeaderBgImg] != "" && file_exists(DIR_IMAGE . $this->data[$HeaderBgImg])) {
			$this->data[$HeaderBgImg_Preview] = $this->model_tool_image->resize($this->data[$HeaderBgImg], 100, 100);
		} else {
			$this->data[$HeaderBgImg_Preview] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}
		
		// NO IMAGE
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		
			
		$this->response->setOutput($this->render());

		
	}
	
	private function validate() {

		if (!$this->user->hasPermission('modify', 'module/rgen_theme')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>