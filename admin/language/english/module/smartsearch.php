<?php
//==============================================================================
// Smart Search v201.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================

$version = 'v201.2';

//------------------------------------------------------------------------------
// Heading
//------------------------------------------------------------------------------
$_['heading_title']						= 'Smart Search';

$_['heading_welcome']					= 'Welcome to ' . $_['heading_title'] . '!';
$_['help_first_time']					= '
Some things to note before you get started:
<br /><br />
<ul>
	<li>For help with any setting, make sure to carefully read the help text under the setting name.</li><br />
	<li>All settings are automatically saved when changed. You can tell they are being saved when they turn yellow, signaling that they cannot be edited while they are recorded to the database.</li><br />
</ul>
';

//------------------------------------------------------------------------------
// Search History
//------------------------------------------------------------------------------
$_['tab_search_history']				= 'Search History';
$_['help_search_history']				= 'A value of 0 for "Phase Reached" means that the search was retrieved from the individual search cache.';
$_['heading_search_history']			= 'Search History';
$_['button_reset_search_history']		= 'Reset Search History';

$_['entry_date_start']					= 'Date Start:';
$_['entry_date_end']					= 'Date End:';
$_['entry_combine_same_searches']		= 'Combine Same Searches:';
$_['entry_limit']						= 'Limit:';
$_['placeholder_date_format']			= 'YYYY-MM-DD';

$_['button_export_csv']					= 'Export CSV';
$_['button_delete']						= 'Delete';

$_['column_time']						= 'Time';
$_['column_search_terms']				= 'Search Term(s)';
$_['column_phase_reached']				= 'Phase Reached';
$_['column_results']					= 'Results';
$_['column_customer']					= 'Customer';
$_['column_ip_address']					= 'IP Address';
$_['column_action']						= 'Action';
$_['column_first_time']					= 'First Time';
$_['column_last_time']					= 'Last Time';
$_['column_average_results']			= 'Average Results';
$_['column_times_searched']				= 'Times Searched';

$_['text_view_customer']				= 'View customer';
$_['text_guest']						= 'Guest';

//------------------------------------------------------------------------------
// Search Settings
//------------------------------------------------------------------------------
$_['tab_search_settings']				= 'Search Settings';
$_['help_search_settings']				= '<ul>
	<li style="list-style-type: none"><b>Smart Search performs a search of the given keywords in the selected product fields in four phases:</b></li>
	<li>Phase 1: Finding products that contain the keywords as an exact phrase. If nothing is found, it will move on to Phase 2.</li>
	<li>Phase 2: Finding products that contain ALL of the keywords, correctly spelled. If nothing is found, it will move on to Phase 3.</li>
	<li>Phase 3: Finding products that contain ALL of the keywords, within the misspelling tolerance level. If nothing is found, it will move on to Phase 4.</li>
	<li>Phase 4: Finding products that contain ANY of the keywords, within the misspelling tolerance level.</li>
</ul>';
$_['heading_search_settings']			= 'Search Settings';

$_['entry_status']						= 'Smart Search Status: <div class="help-text">Set the status for the extension as a whole.</div>';
$_['entry_testing_mode']				= 'Testing Mode: <div class="help-text">Enabling this will display on the front-end how long each search query takes, for logged-in admin users only. It will also log all database queries into your error log, for reference purposes. Setting to "Ignore Keyword Caching" will display times for both using the keyword cache, and how long an initial search would take without that cache.</div>';
$_['text_enabled_normal']				= 'Enabled, Run as Normal';
$_['text_enabled_ignore']				= 'Enabled, Ignore Keyword Caching';

$_['entry_default_sort']				= 'Default Sorting: <div class="help-text">Select the default way products are sorted in search results. If using a numeric sorting like "Price", you probably want to give all fields the same relevance ranking, since it may not be properly sorted otherwise.</div>';
$_['text_date_added']					= 'Date Added';
$_['text_date_available']				= 'Date Available';
$_['text_date_modified']				= 'Date Modified';
$_['text_model']						= 'Model';
$_['text_name']							= 'Name';
$_['text_price']						= 'Price';
$_['text_quantity']						= 'Quantity in Stock';
$_['text_rating']						= 'Rating';
$_['text_sort_order']					= 'Sort Order';
$_['text_times_purchased']				= 'Times Purchased';
$_['text_times_viewed']					= 'Times Viewed';

$_['entry_default_order']				= 'Default Order: <div class="help-text">Select the default way products are ordered in search results.</div>';
$_['text_ascending']					= 'Ascending';
$_['text_descending']					= 'Descending';

$_['entry_cache_keywords']				= 'Auto-Refresh Keyword Cache: <div class="help-text">The keywords of each search will be cached, making subsequent searches for the same keywords quicker. Select how often to generate new individual cache files, based on how often you update your products.</div>';
$_['text_hourly']						= 'Hourly';
$_['text_daily']						= 'Daily';
$_['text_weekly']						= 'Weekly';
$_['text_monthly']						= 'Monthly';
$_['text_yearly']						= 'Yearly';
$_['text_dont_use_cache']				= 'Don\'t Use Cache';
$_['button_clear_cache']				= 'Clear Cache';

$_['entry_plurals']						= 'Account For Plurals: <div class="help-text">Select whether searches with simple plurals will also give results for the singular. For example, searches for "macs" would also give results for "mac".</div>';

$_['entry_partials']					= 'Include Partial Word Matches: <div class="help-text">Select whether searches include results where the search terms only partially match a word. For example, searches for "mac" would match products containing "macbook".</div>';

$_['entry_min_results']					= 'Minimum Number of Results to Display: <div class="help-text">Enter the minimum number of results to display for each search. If a Phase does not meet the minimum, then Smart Search will continue on to the next Phase, appending products found in sub-sequent Phases to the end of the results.</div>';

$_['entry_subcategories']				= 'Search in Sub-Categories: <div class="help-text">Select whether searches limited to a category will also search within its sub-categories.</div>';

$_['entry_single_redirect']				= 'Single Result Redirect: <div class="help-text">Choose whether to redirect to the product page when a search results in a single product.</div>';

$_['entry_index_database_tables']		= 'Index Database Tables: <div class="help-text">This can help speed up search results, as described in <a target="_blank" href="http://forum.opencart.com/viewtopic.php?f=20&t=39759">this forum topic</a>. Clicking this will automatically run all of these INDEX database queries for you.</div>';
$_['button_index_database_tables']		= 'Index Database Tables';
$_['text_indexed_success']				= 'Your database tables are indexed! Running this in the future will have no affect on your database.';

//------------------------------------------------------------------------------
// Fields Searched
//------------------------------------------------------------------------------
$_['tab_fields_searched']				= 'Fields Searched';
$_['help_fields_searched']				= '<ul><li>For any fields you wish to search, enter a relevance ranking in the box next to the field name. This will determine the order in which results are displayed by default for Phases 1 and 2.</li><li>Each different ranking will result in its own database query, so fewer rankings will be faster. In particular, selecting "Description (Phases 3 & 4)" can slow down search results if you have a lot of products.</li><li>For example, if you enter a relevance of 1 for "Name" and a relevance of 2 for "Model", then products whose name matches the search term(s) will appear before products whose model matches the search term(s).</li></ul>';
$_['heading_fields_searched']			= 'Fields Searched and Relevance Ranking';

$_['text_search_name']					= 'Name:';
$_['text_search_description']			= 'Description (Phases 1 & 2):';
$_['text_search_description_misspelled']= 'Description (Phases 3 & 4):';
$_['text_search_meta_description']		= 'Meta Tag Description:';
$_['text_search_meta_keyword']			= 'Meta Tag Keywords:';
$_['text_search_tag']					= 'Tags:';
$_['text_search_model']					= 'Model:';
$_['text_search_sku']					= 'SKU:';
$_['text_search_upc']					= 'UPC:';
$_['text_search_ean']					= 'EAN:';
$_['text_search_jan']					= 'JAN:';
$_['text_search_isbn']					= 'ISBN:';
$_['text_search_mpn']					= 'MPN:';
$_['text_search_location']				= 'Location:';
$_['text_search_manufacturer']			= 'Manufacturer Name:';
$_['text_search_attribute_group']		= 'Attribute Group:';
$_['text_search_attribute_name']		= 'Attribute Name:';
$_['text_search_attribute_value']		= 'Attribute Value:';
$_['text_search_option_name']			= 'Option Name:';
$_['text_search_option_value']			= 'Option Value:';

//------------------------------------------------------------------------------
// Misspelling Settings
//------------------------------------------------------------------------------
$_['tab_misspelling_settings']			= 'Misspelling Settings';
$_['heading_misspelling_settings']		= 'Misspelling Settings';

$_['entry_tolerance']					= 'Misspelling Tolerance: <div class="help-text">Set the tolerance level when judging misspelled words. A setting of 0% will match anything, while a setting of 100% will match only exact spellings.</div>';

$_['entry_cache_misspelling']			= 'Auto-Refresh Misspelling Cache: <div class="help-text">Select how often to generate new misspelling cache files. This can take a few extra seconds during the search where they are generated, so if you have a lot of products you may want to do this infrequently or disable caching.</div>';

$_['entry_word_length']					= 'Min. Word Length for Cache: <div class="help-text">The minimum number of letters a keyword needs for it to be included in the cache. Set a higher minimum word length if misspelled searches are matching products that include common words, or are taking too long on a large database.</div>';

//------------------------------------------------------------------------------
// Live Search
//------------------------------------------------------------------------------
$_['tab_live_search']					= 'Live Search';
$_['heading_live_search']				= 'Live Search';

$_['entry_live_search']					= 'Enable Live Search: <div class="help-text">Live Search will show products automatically when entering keywords in the header search field.</div>';
$_['entry_live_selector']				= 'Selector: <div class="help-text">Enter a CSS selector for the search field. You only need to change this if your custom template changes the search field, since the default (<code>#search input</code>) will work for most themes.</div>';
$_['entry_live_css']					= 'Additional CSS: <div class="help-text">Add any additional CSS styling here. If your CSS does not seem to be applying, try adding <code>!important</code> at the end of the declarations, to override any other CSS styling.</div>';

// Colors
$_['heading_colors']					= 'Colors';
$_['entry_live_background_color']		= 'Background: <div class="help-text">Set the background color for the live search dropdown.</div>';
$_['entry_live_borders_color']			= 'Borders: <div class="help-text">Set the border color for the live search dropdown.</div>';
$_['entry_live_font_color']				= 'Font: <div class="help-text">Set the font color for the live search dropdown.</div>';
$_['entry_live_highlight_color']		= 'Highlight: <div class="help-text">Set the highlight color when hovering over a product in the live search dropdown.</div>';
$_['entry_live_price_color']			= 'Price: <div class="help-text">Set the color for regular prices in the live search dropdown.</div>';
$_['entry_live_special_color']			= 'Special: <div class="help-text">Set the color for special prices in the live search dropdown.</div>';

// Display
$_['heading_display']					= 'Display';
$_['entry_live_delay']					= 'Delay: <div class="help-text">The delay before the live search results appear, in milliseconds. Setting this lower than 100 or 200 ms may cause the dropdown links to be non-functional.</div>';
$_['entry_live_limit']					= 'Limit: <div class="help-text">The number of products to show.</div>';
$_['entry_live_price']					= 'Price: <div class="help-text">Select whether to show the product price.</div>';
$_['entry_live_model']					= 'Model: <div class="help-text">Select whether to show the product model.</div>';
$_['entry_live_addtocart_button']		= 'Add to Cart Button: <div class="help-text">Select whether to show an Add to Cart button for each product.</div>';
$_['entry_live_addtocart_class']		= 'Add to Cart Button Class: <div class="help-text">Set the button class used by your theme.</div>';
$_['entry_live_description']			= 'Description: <div class="help-text">Set the number of characters to display for product descriptions. Leave blank to show no description.</div>';
$_['text_show']							= 'Show';
$_['text_hide']							= 'Hide';
$_['text_show_with_quantity_field']		= 'Show, With Quantity Field';
$_['text_show_without_quantity_field']	= 'Show, Without Quantity Field';

// Positioning
$_['heading_positioning']				= 'Positioning';
$_['entry_live_top']					= 'Top: <div class="help-text">Optionally set the top offset (in pixels) of the live search dropdown. If the dropdown appears over the search bar in your custom theme, use this to move it down.</div>';
$_['entry_live_left']					= 'Left: <div class="help-text">Optionally set the left offset (in pixels) of the live search dropdown.</div>';
$_['entry_live_right']					= 'Right: <div class="help-text">Optionally set the left offset (in pixels) of the live search dropdown.</div>';

// Sizes
$_['heading_sizes']						= 'Sizes';
$_['entry_live_width']					= 'Dropdown Width: <div class="help-text">Set the live search dropdown width, in pixels or percentage. Use a percentage with responsive themes.</div>';
$_['entry_live_image_width']			= 'Image Width: <div class="help-text">Set the product image width, in pixels. Leave blank to hide the product image.</div>';
$_['entry_live_image_height']			= 'Image Height: <div class="help-text">Set the product image height, in pixels. Leave blank to hide the product image.</div>';
$_['entry_live_product_font']			= 'Product Font Size: <div class="help-text">Set the font size for the product name, in pixels.</div>';
$_['entry_live_description_font']		= 'Description Font Size: <div class="help-text">Set the font size for the product description, in pixels.</div>';

$_['heading_text']						= 'Text';
$_['entry_live_viewall']				= '"View All Results" Text: <div class="help-text">Set the text for the "View All Results" link that appears at the bottom of the AJAX dropdown. HTML is supported.</div>';
$_['entry_live_noresults']				= '"No Results" Text: <div class="help-text">Set the text for the "No Results" text displayed when there are no results for a search. HTML is supported.</div>';
$_['entry_live_addtocart_text']			= '"Add to Cart" Text: <div class="help-text">Set the text for the "Add to Cart" button. HTML is supported.</div>';
$_['entry_live_quantity_text']			= '"Quantity" Text: <div class="help-text">Set the text for the "Quantity" field. HTML is supported.</div>';

//------------------------------------------------------------------------------
// Pre-Search Replacements
//------------------------------------------------------------------------------
$_['tab_pre_search_replacements']		= 'Pre-Search Replacements';
$_['help_pre_search_replacements']		= 'Optionally enter replacements for the keywords before they are searched. For example, you could replace hyphens with spaces, or commonly misspelled product names with correct ones. Pre-search replacements are case-insensitive.';
$_['heading_pre_search_replacements']	= 'Pre-Search Replacements';

$_['column_action']						= 'Action';
$_['column_replace']					= 'Replace';
$_['column_with']						= 'With';

$_['button_add_replacement']			= 'Add Replacement';

//------------------------------------------------------------------------------
// Standard Text
//------------------------------------------------------------------------------
$_['copyright']							= '<hr /><div class="text-center" style="margin: 15px">' . $_['heading_title'] . ' (' . $version . ') &copy; <a target="_blank" href="http://www.getclearthinking.com">Clear Thinking, LLC</a></div>';
$_['standard_select']					= '--- Select ---';
$_['standard_confirm']					= 'This operation cannot be undone. Continue?';
$_['standard_please_wait']				= 'Please wait...';
$_['standard_success']					= 'Success!';
$_['standard_error']					= '<strong>Warning:</strong> You do not have permission to modify ' . $_['heading_title'] . '!';
?>