<?php
//==============================================================================
// Filter by Price Module v230.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================

$version = 'v230.1';

//------------------------------------------------------------------------------
// Heading
//------------------------------------------------------------------------------
$_['heading_title']						= 'Filter by Price Module';

//------------------------------------------------------------------------------
// Extension Settings
//------------------------------------------------------------------------------
$_['help_module_locations']				= 'You can set your module locations in';
$_['heading_module_list']				= 'Module List';

$_['column_module_name']				= 'Module Name';
$_['column_edit_module']				= 'Edit Module';
$_['column_copy_module']				= 'Copy Module';
$_['column_delete_module']				= 'Delete module';

$_['button_add_module']					= 'Add Module';
$_['heading_add_new_module']			= 'Add a New Module';
$_['heading_edit']						= 'Edit';

//------------------------------------------------------------------------------
// Module Settings
//------------------------------------------------------------------------------
$_['help_caching']						= 'To improve performance, filtered product results and "relevant values" data are cached for the front-end. To clear these cache files, you can reload any ' . $_['heading_title'] . ' admin page.';

$_['tab_module_settings']				= 'Module Settings';
$_['heading_module_settings']			= 'Module Settings';

$_['entry_module_status']				= 'Status: <div class="help-text">Choose whether to enable or disable the module.</div>';
$_['entry_module_name']					= 'Name: <div class="help-text">Enter a name for the module, for admin reference only.</div>';
$_['entry_module_caching']				= 'Caching: <div class="help-text">Choose whether to cache the filter choices. It is recommended to leave this Disabled while setting up and testing the module, and then Enabled when using it in a live store. Don\'t forget: you can clear the cache by reloading any ' . $_['heading_title'] . ' admin page.</div>';
$_['entry_module_heading']				= 'Heading: <div class="help-text">Enter the heading text for the module box, and associated product listing page. HTML is supported.</div>';
$_['entry_module_block_width']			= 'Filter Block Width: <div class="help-text">Set the block width for each filter, in pixels. You can also enter a % sign after the value to use a percentage of the page width. Note: This setting only applies when the module is in the content top/bottom positions. Column left/right positions will always show filters stacked vertically.</div>';
$_['entry_module_block_height']			= 'Filter Block Height: <div class="help-text">Set the maximum block height for each filter, in pixels. If the choices exceed the maximum height, the list will be scrollable. Leave blank to have no maximum height, so all choices are always displayed.</div>';
$_['entry_module_choice_display']		= 'Default Choices to Display: <div class="help-text">Enter the default number of choices to show when there is a long list. Choices below that will be hidden, with a "Show More" link which will show all the choices when clicked.</div>';
$_['entry_module_default_sorting']		= 'Default Sorting: <div class="help-text">Choose the default sorting method for the filtered product page.</div>';

$_['text_default']						= 'Default';
$_['text_name_asc']						= 'Name (A - Z)';
$_['text_name_desc']					= 'Name (Z - A)';
$_['text_price_asc']					= 'Price (Low &gt; High)';
$_['text_price_desc']					= 'Price (High &gt; Low)';
$_['text_rating_asc']					= 'Rating (Lowest)';
$_['text_rating_desc']					= 'Rating (Highest)';
$_['text_model_asc']					= 'Model (A - Z)';
$_['text_model_desc']					= 'Model (Z - A)';
$_['text_bestselling']					= 'Bestselling';
$_['text_latest']						= 'Latest';
$_['text_most_popular']					= 'Most Popular';

$_['entry_module_automatic_filter']		= 'Automatically Filter After: <div class="help-text">Enter the number of seconds after selecting a filter that the results will automatically reload. Leave blank to require the customer click the "Filter" button. Note: automatically filtering results will result in more requests to your server, and could be much slower for customers that want to change multiple filter values at the same time.</div>';
$_['entry_module_page_loading']			= 'Load Pages: <div class="help-text">Choose whether pages load normally, or load via ajax. This will occur after filtering from the module, and after clicking pagination links on the filtered results. Pages loaded via ajax will not be recorded in the browser history.<br /><br />If you see a temporary blank page when using the ajax "Quick Method", you can switch to the "Slower Method" to prevent this from happening. It should only add a second or two to the loading time.</div>';

$_['text_normally']						= 'Normally';
$_['text_via_ajax_quick_method']		= 'Via AJAX, Quick Method';
$_['text_via_ajax_slower_method']		= 'Via AJAX, Slower Method';

// Location
$_['heading_location']					= 'Location';

$_['entry_module_layout_id']			= 'Layout:';
$_['entry_module_position']				= 'Position:';
$_['entry_module_sort_order']			= 'Sort Order:';

$_['text_content_top']					= 'Content Top';
$_['text_column_left']					= 'Column Left';
$_['text_column_right']					= 'Column Right';
$_['text_content_bottom']				= 'Content Bottom';

$_['entry_module_location']				= 'Module Location:';
$_['help_module_locations']				= 'You can set your module locations in';

// Module Text
$_['heading_module_text']				= 'Module Text';

$_['entry_module_show_more_text']		= '"Show More" Text: <div class="help-text">Enter the text displayed for the "Show More" link when there are more choices than the "Choices to Display" setting.</div>';
$_['entry_module_show_all_text']		= '"Show All" Text: <div class="help-text">Enter the text displayed for the "Show All" link, used when setting the category or manufacturer filter is set to "Links". Leave blank to hide.</div>';
$_['entry_module_all_text']				= '"All" Text: <div class="help-text">Enter the text displayed for the "All" option of Select Dropdowns.</div>';
$_['entry_module_clear_filter_text']	= '"Clear Filter" Text: <div class="help-text">Enter the text for the "Clear" link for each filter. HTML is supported. Leave blank to hide the link.</div>';
$_['entry_module_clear_all_filters_text']	= '"Clear All Filters" Text: <div class="help-text">Enter the text for the "Clear All Filters" link at the bottom of the module. HTML is supported. Leave blank to hide the link.</div>';
$_['entry_module_filter_button']		= '"Filter" Button: <div class="help-text">Enter the text for the "Filter" button. HTML is supported. Leave blank to hide the button.</div>';
$_['entry_module_mobile_button']		= 'Mobile Button Text: <div class="help-text">Enter the text for the button displayed when the customer using a mobile device, to activate the module. HTML is supported.</div>';
$_['entry_module_mobile_close']			= 'Mobile Close Button: <div class="help-text">Enter the symbol or text for the close button displayed when the customer is using a mobile device. HTML is supported.</div>';

//------------------------------------------------------------------------------
// common text
//------------------------------------------------------------------------------
$_['text_hide']							= '--- Hide ---';
$_['text_checkboxes']					= 'Checkboxes';
$_['text_links']						= 'Links';
$_['text_radio_buttons']				= 'Radio Buttons';
$_['text_select_dropdown']				= 'Select Dropdown';

$_['text_expanded']						= 'Expanded';
$_['text_collapsed']					= 'Collapsed';

$_['text_all_values']					= 'All Values';
$_['text_only_relevant_values']			= 'Only Relevant Values';

$_['entry_set_all_dropdowns_to']		= 'Set All Dropdowns To: <div class="help-text">Use this to set all the following dropdowns to a particular value.</div>';
$_['text_set_all_to']					= 'Set all to...';

//------------------------------------------------------------------------------
// Category Filter
//------------------------------------------------------------------------------
$_['tab_category_filter']				= 'Category Filter';
$_['heading_category_filter']			= 'Category Filter';

$_['entry_module_category_filter']		= 'Category Filter: <div class="help-text">Choose whether to show the category filter. If not used, products will not be filtered by category.<br /><br />If you choose "Links", only top-level categories will be initially shown. Clicking on a link will immediately apply the filter, and then show the sub-categories of the selected category.</div>';
$_['entry_module_category_sort_order']	= 'Sort Order: <div class="help-text">Choose the sort order for the category filter, in relation to other filters.</div>';
$_['entry_module_category_heading']		= 'Heading: <div class="help-text">Enter the heading displayed above the category filter. HTML is supported.</div>';
$_['entry_module_category_display']		= 'Default Display: <div class="help-text">Choose whether the category filter is expanded or collapsed by default.</div>';
$_['entry_module_category_count']		= 'Show Product Counts: <div class="help-text">Choose whether to show a product count next to the category name. Note: Selecting "Yes" may cause some slowdown depending on your database size.</div>';
$_['entry_module_category_choices']		= 'Choices: <div class="help-text">Choose whether all categories are shown, or only categories relevant to the current product results. Note: Selecting "Only Relevant Values" may cause some slowdown depending on your database size.</div>';
$_['entry_module_category_images']		= 'Category Image Size: <div class="help-text">Set the dimension size for category images (in pixels). For example, to show 25x25 images enter "25". Categories without images assigned to them will not show anything. Leave blank to hide all category images.</div>';
$_['entry_module_category_subcategories']	= 'Always Include Sub-Categories: <div class="help-text">Enable this to always include results from sub-categories of the selected category or categories.</div>.';

$_['heading_categories']				= 'Categories';
$_['entry_module_categories']			= 'Show Categories: <div class="help-text">Choose the categories that will be shown in the module. Any categories not selected will never appear in the module as a choice.</div>';
$_['text_select_all']					= 'Select All';
$_['text_unselect_all']					= 'Unselect All';

//------------------------------------------------------------------------------
// Manufacturer Filter
//------------------------------------------------------------------------------
$_['tab_manufacturer_filter']			= 'Manufacturer Filter';
$_['heading_manufacturer_filter']		= 'Manufacturer Filter';

$_['entry_module_manufacturer_filter']	= 'Manufacturer Filter: <div class="help-text">Choose whether to show the manufacturer filter. If not used, products will not be filtered by manufacturer.</div>';
$_['entry_module_manufacturer_sort_order']	= 'Sort Order: <div class="help-text">Choose the sort order for the manufacturer filter, in relation to other filters.</div>';
$_['entry_module_manufacturer_heading']	= 'Heading: <div class="help-text">Enter the heading displayed above the manufacturer filter. HTML is supported.</div>';
$_['entry_module_manufacturer_display']	= 'Default Display: <div class="help-text">Choose whether the manufacturer filter is expanded or collapsed by default.</div>';
$_['entry_module_manufacturer_count']	= 'Show Product Counts: <div class="help-text">Choose whether to show a product count next to the manufacturer name. Note: Selecting "Yes" may cause some slowdown depending on your database size.</div>';
$_['entry_module_manufacturer_choices']	= 'Choices: <div class="help-text">Choose whether all manufacturers are shown, or only manufacturers relevant to the current product results. Note: Selecting "Only Relevant Values" may cause some slowdown depending on your database size.</div>';
$_['entry_module_manufacturer_images']	= 'Manufacturer Image Size: <div class="help-text">Set the dimension size for manufacturer images (in pixels). For example, to show 25x25 images enter "25". Manufacturers without images assigned to them will not show anything. Leave blank to hide all manufacturer images.</div>';

//------------------------------------------------------------------------------
// Price Filter
//------------------------------------------------------------------------------
$_['tab_price_filter']					= 'Price Filter';
$_['heading_price_filter']				= 'Price Filter';

$_['entry_module_price_filter']			= 'Price Filter: <div class="help-text">Choose whether to show the price filter. If not used, products will not be filtered by price.</div>';
$_['entry_module_price_sort_order']		= 'Sort Order: <div class="help-text">Choose the sort order for the price filter, in relation to other filters.</div>';
$_['entry_module_price_display']		= 'Default Display: <div class="help-text">Choose whether the price filter is expanded or collapsed by default.</div>';
$_['entry_module_price_count']			= 'Show Product Counts: <div class="help-text">Choose whether to show a product count next to the price range. Note: Selecting "Yes" may cause some slowdown depending on your database size.</div>';
$_['entry_module_price_flexible']		= 'Show Flexible Filter: <div class="help-text">If enabled, customers will be able to set their own lower and upper limits when filtering by price, in addition to the Price Ranges set below. To show only the flexible filter, set this to "Enabled" and leave the Price Ranges fields blank.</div>';

$_['entry_module_price_heading']		= 'Heading: <div class="help-text">Enter the heading displayed above the price filter. HTML is supported.</div>';
$_['entry_module_price_bottom_text']	= 'Bottom Range Text: <div class="help-text">Enter the text displayed for the bottom price range. Use [price] in place of the price point.</div>';
$_['entry_module_price_middle_text']	= 'Middle Range Text: <div class="help-text">Enter the text displayed for the middle price ranges. Use [from] and [to] in place of the price points.</div>';
$_['entry_module_price_top_text']		= 'Top Range Text: <div class="help-text">Enter the text displayed for the top price range. Use [price] in place of the price point.</div>';

// Price Ranges
$_['heading_price_ranges']				= 'Price Ranges';
$_['help_price_ranges']					= 'Using commas, enter the price points at which to separate the price ranges. For example, if you want to have ranges of (1) Under $25, (2) $25 - $50, (3) $50 - $100, and (4) $100 and up, then you would enter: <code>25, 50, 100</code>';
$_['entry_price_range']					= 'Price Range:';

//------------------------------------------------------------------------------
// Standard Text
//------------------------------------------------------------------------------
$_['copyright']							= '<hr /><div class="text-center" style="margin: 15px">' . $_['heading_title'] . ' (' . $version . ') &copy; <a target="_blank" href="http://www.getclearthinking.com">Clear Thinking, LLC</a></div>';

$_['standard_autosaving_enabled']		= 'Auto-Saving Enabled';
$_['standard_confirm']					= 'This operation cannot be undone. Continue?';
$_['standard_error']					= '<strong>Error:</strong> You do not have permission to modify ' . $_['heading_title'] . '!';
$_['standard_max_input_vars']			= '<strong>Warning:</strong> The number of settings is close to your <code>max_input_vars</code> server value. You should enable auto-saving to avoid losing any data.';
$_['standard_please_wait']				= 'Please wait...';
$_['standard_saved']					= 'Saved!';
$_['standard_saving']					= 'Saving...';
$_['standard_select']					= '--- Select ---';
$_['standard_success']					= 'Success!';
$_['standard_testing_mode']				= 'Your log is too large to open! Clear it first, then run your test again.';
$_['standard_vqmod']					= '<strong>Warning:</strong> This extension requires vQmod, which is not installed on your store. Please download it from <a target="_blank" href="http://www.vqmod.com">www.vqmod.com</a> and follow the installation instructions.';

$_['standard_module']					= 'Modules';
$_['standard_shipping']					= 'Shipping';
$_['standard_payment']					= 'Payments';
$_['standard_total']					= 'Order Totals';
$_['standard_feed']						= 'Feeds';
?>