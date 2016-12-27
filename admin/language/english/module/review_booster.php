<?php
// Heading
$_['heading_title']                    = 'Review Booster';
$_['datetime_format']                  = 'd/m/Y H:i:s';

// Text
$_['text_module']                      = 'Modules';
$_['text_success']                     = 'Success: You have modified module Review Booster!';
$_['text_email_removed']               = 'Success: Notification removed!';
$_['text_multiselect']                 = 'Keep CTRL pressed for multiselect.';
$_['text_day']                         = 'days';
$_['text_per_order']                   = 'A one form for all products';
$_['text_per_product']                 = 'Email will be sent for each product';
$_['text_per_product_single']          = 'All products in a one email with separate forms';
$_['text_percentage']                  = 'Percentage';
$_['text_fixed']                       = 'Fixed amount';
$_['text_coupon']                      = 'Code: %s<br />Date end: %s<br />Used: <a href="%s">%s</a>';
$_['text_no_review']                   = 'No review';
$_['text_no_coupon']                   = 'No coupon';
$_['text_test']                        = 'This notification was sent as a test!';

// Entry
$_['entry_module_status']              = 'Module status';
$_['entry_subject']                    = 'Email Subject';
$_['entry_description']                = 'Message';
$_['entry_order_status']               = 'Status order';
$_['entry_new_order_status']           = 'A new status of order';
$_['entry_notify']                     = 'Notify customer about the change of order status';
$_['entry_exclude_customer_group']     = 'Exclude customer group';
$_['entry_day']                        = 'After days';
$_['entry_previous']                   = 'Send an email to previous customers';
$_['entry_type']                       = 'Review type';
$_['entry_product_image_status']       = 'Product image';
$_['entry_width']                      = 'Width';
$_['entry_height']                     = 'Height';
$_['entry_product_limit']              = 'Product limit';
$_['entry_verified_buyer_status']      = 'Verified Buyer';
$_['entry_coupon_status']              = 'Discount status';
$_['entry_coupon_discount']            = 'Discount';
$_['entry_coupon_value']               = 'Value';
$_['entry_coupon_validity']            = 'Validity';
$_['entry_star']                       = 'Image of ratings';
$_['entry_noticed_status']             = 'How did you hear about our website';
$_['entry_noticed']                    = 'Add value';
$_['entry_image_type']                 = 'Encoding in base64';
$_['entry_approve_review_status']      = 'Auto approve reviews';
$_['entry_approve_review_rating']      = 'The minimum rating';
$_['entry_apr_status']                 = 'Ratings from Advanced Product Reviews';
$_['entry_apr_image_status']           = 'Upload images';
$_['entry_verified_buyer_text']        = 'Verified Buyer Text';
$_['entry_link_text']                  = 'Link Text';
$_['entry_test']                       = 'Test email';

// Column
$_['column_email']                     = 'Customer email';
$_['column_date_added']                = 'Email sent';
$_['column_order_id']                  = 'Order ID';
$_['column_product']                   = 'Product';
$_['column_coupon']                    = 'Coupon';
$_['column_date_review']               = 'Review date';

// Help
$_['help_order_status']                = 'Status of the order to which it is to send email.';
$_['help_new_order_status']            = 'A new status of order after the notification is sent.';
$_['help_exclude_customer_group']      = 'Customer groups to which DO NOT send notifications.';
$_['help_day']                         = 'Review request email will be send after X days of setting the order status to a specific value (orders selected by Date Modified).';
$_['help_previous']                    = 'Enable to send emails after X days and more, disable to send exactly after X days.';
$_['help_type']                        = 'This will allow you to send a review request for an each product or for a full order.';
$_['help_product_limit']               = 'Reduce the limit of products to the review. Leave blank or enter 0 for unlimited.';
$_['help_verified_buyer_status']       = 'Additional note \'Verified Buyer\' beside the name of the reviewer.';
$_['help_coupon_status']               = 'Coupon code will be generated for each user individually. Coupon code displayed after submitting the form of review.';
$_['help_image_type']                  = 'Images to ratings in the base64 encoded. Remember! Not every e-mail client that supports this!';
$_['help_noticed_status']              = 'Enable it, if you want to show this field in the form.';
$_['help_apr']                         = 'If you have a module <a href="http://www.adikon.eu/advanced-product-review-review-manager" target="_blank">Advanced Product Reviews</a>, enable it, if you want show in review form created ratings to rating.';
$_['help_approve_review_status']       = 'Automatically approve reviews sent by customer.';
$_['help_apr_image_status']            = 'If you have a module <a href="http://www.adikon.eu/advanced-product-review-review-manager" target="_blank">Advanced Product Reviews</a>, enable it, if you want allow customer to upload images.';
$_['help_link_text']                   = 'Text for link when you use a shortcode {link} in content of email.';
$_['help_test']                        = 'Enter your email address to send the test message. Before must save settings.';

// Tab
$_['tab_general']                      = 'Setting';
$_['tab_history']                      = 'History';

// Button
$_['button_test']                      = 'Send';
$_['button_view']                      = 'View';

// Error
$_['error_permission']                 = 'Warning: You do not have permission to modify module Review Booster!';
$_['error_required']                   = 'Warning: Please check the form carefully for errors!';
$_['error_module']                     = 'Module does not exist!';
$_['error_order_status']               = 'Select an order status at which to send email to the customer!';
$_['error_day']                        = 'Define after how many days to send the email!';
$_['error_type']                       = 'Please choose the kind of email that will be send to the customer!';
$_['error_email']                      = 'The field Subject email and Message is required!';
?>