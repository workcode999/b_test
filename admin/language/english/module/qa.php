<?php
$_['extension_name']                    = 'Product Questions &amp; Answers';

// Heading
$_['heading_title']                     = '<i class="fa fa-question-circle" style="font-size:14px;color:#F7951D;"></i> <strong>' . $_['extension_name'] . '</strong>' . (defined("PQA_STATUS") ? '<span style="display:inline-block;margin-left:20px;">' . (PQA_STATUS ? '<i style="color:#3c763d">[ Enabled ]</i>' : '<i style="color:#a94442">[ Disabled ]</i>') . '</span>' : '');

// Buttons
$_['button_apply']                      = 'Apply';
$_['button_upgrade']                    = 'Upgrade';
$_['button_purchase_license']           = 'Purchase Additional License';

// Tabs
$_['tab_settings']                      = 'Settings';
$_['tab_form']                          = 'Form';
$_['tab_qa']                            = 'Q &amp A';
$_['tab_support']                       = 'Support';
$_['tab_about']                         = 'About';
$_['tab_general']                       = 'General';
$_['tab_faq']                           = 'FAQ';
$_['tab_services']                      = 'Services';
$_['tab_changelog']                     = 'Changelog';
$_['tab_extension']                     = 'Extension';

// Text
$_['text_success_upgrade']              = '<strong>Success!</strong> You have upgraded ' . $_['extension_name'] . ' to version <strong>%s</strong>!';
$_['text_success_update']               = '<strong>Success!</strong> You have updated ' . $_['extension_name'] . ' settings!';
$_['text_success_hooks_update']         = '<strong>Success!</strong> ' . $_['extension_name'] . ' event hooks updated!';
$_['text_toggle_navigation']            = 'Toggle navigation';
$_['text_license']                      = 'License';
$_['text_extension_information']        = 'Extension information';
$_['text_legal_notice']                 = 'Legal notice';
$_['text_terms']                        = 'Terms &amp; Conditions';
$_['text_support_subject']              = $_['extension_name'] . ' support needed';
$_['text_license_text']                 = 'Please be aware that this product has a <strong>per-domain license</strong>, meaning you can use it <em>only on a single domain</em> (sub-domains count as separate domains). <strong>You will need to purchase a separate license for each domain you wish to use this extension on.</strong>';
$_['text_other_extensions']             = 'If you like this extension you might also be interested in <a href="%s" class="alert-link" target="_blank">my other extensions</a>.';
$_['text_module']                       = 'Modules';
$_['text_faq']                          = 'Frequently Asked Questions';
$_['text_first_page']                   = 'First Page';
$_['text_all']                          = 'All';
$_['text_store_email_address']          = 'Store e-mail address';
$_['text_customer_email_address']       = 'Customer e-mail address';
$_['text_saving']                       = 'Saving ...';
$_['text_upgrading']                    = 'Upgrading ...';
$_['text_loading']                      = 'Loading ...';
$_['text_canceling']                    = 'Canceling ...';

// Help texts
$_['help_dashboard_widget']             = 'Show total number of questions with a new dashboard widget.';
$_['help_new_question_notification']    = 'Send a notification email to the specified email address(es) when a new question is submitted.';
$_['help_question_reply_notification']  = 'Send a notification email to the question author after the question has been answered in the admin panel.';
$_['help_notification_emails']          = 'Comma separated list of e-mail addresses where to send notifications about new questions. For multilingual stores you can set a different e-mail address for each language.';
$_['help_notification_email_from']      = 'The email address from which the notification email is sent from. In case customer e-mail address is selected, but customer does not leave an e-mail address, store e-mail address is used instead.';
$_['help_display_questions']            = 'If disabled, no questions will be shown on the product page.';
$_['help_items_per_page']               = 'Enter 0 to display all questions &amp; answers on one page.';
$_['help_preload']                      = 'Load questions &amp; answers without AJAX call to improve SEO visibility.';
$_['help_display_all_languages']        = 'If disabled, only questions in the current language are displayed in Store Front.';
$_['help_remove_sql_changes']           = 'Remove all SQL changes when <strong>uninstalling</strong> the module.';
$_['help_purchase_additional_licenses'] = 'You need to purchase additional extension licenses to activate the extension on these stores';

// Entry
$_['entry_installed_version']           = 'Installed version';
$_['entry_extension_status']            = 'Extension status';
$_['entry_dashboard_widget']            = 'Dashboard widget';
$_['entry_new_question_notification']   = 'New question alert';
$_['entry_notification_emails']         = 'Notification e-mails';
$_['entry_notification_email_from']     = 'Notification e-mail from';
$_['entry_question_reply_notification'] = 'Question reply alert';
$_['entry_display_all_languages']       = 'Show questions in all languages';
$_['entry_remove_sql_changes']          = 'Remove SQL changes';
$_['entry_form_display_name']           = 'Display name field';
$_['entry_form_require_name']           = 'Is name required?';
$_['entry_form_display_email']          = 'Display email field';
$_['entry_form_require_email']          = 'Is email required?';
$_['entry_form_display_phone']          = 'Display phone field';
$_['entry_form_require_phone']          = 'Is phone number required?';
$_['entry_form_display_custom']         = 'Display custom field';
$_['entry_form_require_custom']         = 'Is custom field value required?';
$_['entry_form_custom_field_name']      = 'Custom field name';
$_['entry_form_display_captcha']        = 'Display captcha';
$_['entry_form_require_captcha']        = 'Is captcha required?';
$_['entry_display_questions']           = 'Display questions &amp; answers';
$_['entry_new_questions_status']        = 'New question status';
$_['entry_items_per_page']              = 'Questions per page';
$_['entry_preload']                     = 'Preload questions';
$_['entry_display_question_author']     = 'Display question author';
$_['entry_display_question_date']       = 'Display question date';
$_['entry_display_answer_author']       = 'Display answer author';
$_['entry_display_answer_date']         = 'Display answer date';
$_['entry_extension_name']              = 'Name';
$_['entry_extension_compatibility']     = 'Compatibility';
$_['entry_extension_store_url']         = 'Store URL';
$_['entry_copyright_notice']            = 'Copyright notice';
$_['entry_active_on']                   = 'Active on';
$_['entry_inactive_on']                 = 'Inactive on';

// Error
$_['error_permission']                  = '<strong>Error!</strong> You do not have permission to modify extension ' . $_['extension_name'] . '!';
$_['error_warning']                     = '<strong>Warning!</strong> Please check the form carefully for errors!';
$_['error_vqmod']                       = '<strong>Warning!</strong> VQMod class cannot be found. Please verify that vQmod has been installed. You can download vQmod for free from the official website <a href="http://www.vqmod.com" class="alert-link">www.vqmod.com</a>!';
$_['error_vqmod_script']                = '<strong>Warning!</strong> The extension vQmod script is not working. Please check that it exists and is not disabled. The extension will not work without this script.';
$_['error_missing_table']               = '<strong>Error!</strong> Your SQL database seems to be missing table \'%s\'!';
$_['error_missing_column']              = '<strong>Error!</strong> Your SQL table \'%s\' seems to be missing column \'%s\'!';
$_['error_unsaved_settings']            = '<strong>Warning!</strong> There are unsaved settings! Please save the settings.';
$_['error_version']                     = '<strong>Info!</strong> ' . $_['extension_name'] . ' version <strong>%s</strong> installation files found. You need to upgrade ' . $_['extension_name'] . '!';
$_['error_upgrade_database']            = '<strong>Error!</strong> Failed to upgrade database structure!';
$_['error_ajax_request']                = 'An AJAX error occured!';
$_['error_items_per_page']              = 'This value must be a positive integer greater than or equal to 0.';
$_['error_custom_field_name']           = 'Please enter a custom field name!';
$_['error_missing_email']               = 'You need to provide at least one e-mail address!';
$_['error_email']                       = 'The field contains invalid e-mail address(es)!';
$_['error_positive_integer']            = 'This value must be greater than or equal to 0';
