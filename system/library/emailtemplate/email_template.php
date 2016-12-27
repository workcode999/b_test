<?php

if (!defined('DIR_SYSTEM')) exit;

class EmailTemplate {

	public static $version = '2.0.12';

	public $data = array();

	private $registry;
	private $request;
	private $config;
	private $load;
	private $model;

	private $built = false;
	
	private $html = null;
	private $content = '';

	/**
	 * @param Request $request
	 */
	public function __construct(Request $request, Registry $registry) {
		$this->registry = $registry;
		$this->request = $request;
		$this->config = $registry->get('config');
		$this->load = $registry->get('load');

		$this->data['language_id'] = $this->config->get("config_language_id");

		$this->data['store_id'] = $this->config->get("config_store_id");

	    $oCustomer = $registry->get('customer');
		
		if ($oCustomer && $oCustomer instanceof Customer && $oCustomer->isLogged()) {
		    $this->data['customer_id'] = $oCustomer->getId();
		    $this->data['customer_group_id'] = $oCustomer->getGroupId();
		} else {
		    $this->data['customer_id'] = 0;
		    $this->data['customer_group_id'] = $this->config->get('config_customer_group_id');
		}
		
		$this->load->model('module/emailtemplate');
		$this->model = new ModelModuleEmailTemplate($this->registry);

		if (isset($request->server['HTTPS']) && (($request->server['HTTPS'] == 'on') || ($request->server['HTTPS'] == '1'))) {
			$this->data['server'] = defined('HTTPS_CATALOG') ? HTTPS_CATALOG : HTTPS_SERVER;
		} else {
			$this->data['server'] = defined('HTTP_CATALOG') ? HTTP_CATALOG : HTTP_SERVER;
		}
	}

	/**
	 * Load Config
	 */
	public function load($data = null) {
	   if (is_array($data)) {				
			if (isset($data['language_id'])) {
				$this->data['language_id'] = intval($data['language_id']);
			}

			if (isset($data['store_id'])) {
				$this->data['store_id'] = intval($data['store_id']);
			}
			
			if (isset($data['emailtemplate_config_id'])) {
				$this->data['emailtemplate_config_id'] = intval($data['emailtemplate_config_id']);
			}
		} else if (is_numeric($data)) {
			$this->data['emailtemplate_config_id'] = intval($data);
		} 
			
		if (isset($this->data['emailtemplate_config_id'])) {
			$this->data['config'] = $this->model->getConfig($this->data['emailtemplate_config_id']);
		} else {	
			// Load relevant config form store/language		
			$config_load = array('store_id' => $this->data['store_id'], 'language_id' => $this->data['language_id']);
				
			$configs = $this->model->getConfigs($config_load);
						
			if (!$configs) {
				$configs = $this->model->getConfigs();
			}
			
			if ($configs) {
				if (count($configs) == 1) {
					$this->data['config'] = $configs[0];
				} elseif (count($configs) > 1) {
					foreach ($configs as &$config) {
						$config['power'] = 0;
						foreach ($config_load as $_key => $_value) {
							$config['power'] = $config['power'] << 1;
							if (!empty($config[$_key]) && $config[$_key] == $_value) {
								$config['power'] |= 1;
							}
						}
					}
					unset($config);
					$this->data['config'] = $configs[0];
			
					foreach ($configs as $config) {
						if ($this->data['config']['power'] < $config['power']) {
							$this->data['config'] = $config;
						}
					}
				}
			}
				
			$this->data['emailtemplate_config_id'] = $this->data['config']['emailtemplate_config_id'];
		}
		
		if (!$this->data['config']) {
			$this->data['config'] = $this->model->getConfig(1);
		}
		
		if (!$this->data['config']) {
			return false;
		}
		
		$this->data['config'] = $this->model->formatConfig($this->data['config']);

		$this->data['emailtemplate_config_id'] = $this->data['config']['emailtemplate_config_id'];

		foreach($this->data['config'] as $key => $val) {
			if (strpos($key, 'emailtemplate_config_') === 0 && substr($key, -3) != '_id') {
				unset($this->data['config'][$key]);
				$this->data['config'][substr($key, 21)] = $val; #21=strlen('emailtemplate_config_')
			} else {
				$this->data['config'][$key] = $val;
			}
		}

		$config_keys = array('title', 'name', 'url', 'owner', 'address', 'email', 'telephone', 'fax', 'logo');

		if ($this->config->get('config_store_id') == $this->data['store_id']) {
			foreach($config_keys as $_key) {
				$this->data['store_'.$_key] = $this->config->get('config_'.$_key);
			}
		} else {
			$this->load->model('setting/store');
			$this->load->model('setting/setting');

			$this->model_setting_store = new ModelSettingStore($this->registry);
			$this->model_setting_setting = new ModelSettingSetting($this->registry);

			$store_info = array_merge(
				$this->model_setting_setting->getSetting("config", $this->data['store_id']),
				$this->model_setting_store->getStore($this->data['store_id'])
			);
			
			foreach($config_keys as $_key) {
				if (isset($store_info[$_key])) {
					$this->data['store_'.$_key] =  $store_info[$_key];
				} elseif (isset($store_info['config_'.$_key])) {
					$this->data['store_'.$_key] =  $store_info['config_'.$_key];
				} else {
					$this->data['store_'.$_key] =  '';
				}
			}
		}

		if (!$this->data['store_url']) {
			$this->data['store_url'] = $this->data['server'];
		}
		
		$this->data['title'] = $this->data['store_name'];

		$this->html = null;

		return true;
	}

	/**
     * Check if template loaded
     * @return boolean
     */
    public function isLoaded() {
    	return (!empty($this->data['config']));
    }

	/**
     * Build template
     *
     * @return object
     */
    public function build() {
        if (!$this->isLoaded()) return false;

        $this->built = true;

        $this->data['config']['theme_dir'] = $this->data['config']['theme'] . '/template/mail/';

        foreach(array('top','bottom','left','right') as $var) {
        	$cells = '';
        	if ($this->data['config']['shadow_'.$var]['start'] && $this->data['config']['shadow_'.$var]['end'] &&  $this->data['config']['shadow_'.$var]['length'] > 0) {
        		$gradient = $this->_generateGradientArray($this->data['config']['shadow_'.$var]['start'], $this->data['config']['shadow_'.$var]['end'], $this->data['config']['shadow_'.$var]['length']);
        		foreach($gradient as $hex => $width) {
        			switch($var) {
        				case 'top':
        				case 'bottom':
        					$cells .= "<tr class='emailShadow'><td bgcolor='#{$hex}' style='background:#{$hex}; height:1px; font-size:1px; line-height:0; mso-margin-top-alt:1px' height='1'>&nbsp;</td></tr>\n";
        					break;
        				default:
        					$cells .= "<td class='emailShadow' bgcolor='#{$hex}' style='background:#{$hex}; width:{$width}px !important; font-size:1px; line-height:0; mso-margin-top-alt:1px' width='{$width}'>&nbsp;</td>\n";
        					break;
        			}

        			$this->data['config']['shadow_'.$var]['bg'] = $cells;
        		}
        	}
        }
        
        foreach (array('top', 'bottom') as $v) {
            foreach (array('left', 'right') as $h) {
                if (!empty($this->data['config']['shadow_'.$v][$h.'_img'])) {
                    $this->data['config']['shadow_'.$v][$h.'_img'] = ($this->data['config']['shadow_'.$v][$h.'_img']) ? $this->getImageUrl($this->data['config']['shadow_'.$v][$h.'_img']) : '';
                    $this->data['config']['shadow_'.$v][$h.'_img_height'] = $this->data['config']['shadow_'.$v]['length'] + $this->data['config']['shadow_'.$v]['overlap'];
                    $this->data['config']['shadow_'.$v][$h.'_img_width'] = $this->data['config']['shadow_'.$h]['length'] + $this->data['config']['shadow_'.$h]['overlap'];
                }
            }
        }

        $this->data['config']['head_text'] = html_entity_decode($this->data['config']['head_text'], ENT_QUOTES, 'UTF-8');
        $this->data['config']['page_footer_text'] = html_entity_decode($this->data['config']['page_footer_text'], ENT_QUOTES, 'UTF-8');
        $this->data['config']['footer_text'] = html_entity_decode($this->data['config']['footer_text'], ENT_QUOTES, 'UTF-8');

        if (!empty($this->data['emailtemplate']['comment'])) {
        	$this->data['emailtemplate']['comment'] = html_entity_decode($this->data['emailtemplate']['comment'], ENT_QUOTES, 'UTF-8');
        }

        if (!empty($this->data['emailtemplate']['unsubscribe_text'])) {
        	$this->data['emailtemplate']['unsubscribe_text'] = html_entity_decode($this->data['emailtemplate']['unsubscribe_text'], ENT_QUOTES, 'UTF-8');
        }

        $this->data['config']['header_bg_image'] = ($this->data['config']['header_bg_image']) ? $this->getImageUrl($this->data['config']['header_bg_image']) : '';

        $this->data['config']['email_full_width'] = $this->data['config']['email_width'] + ($this->data['config']['shadow_left']['length'] + $this->data['config']['shadow_right']['length']);

        if ($this->data['config']['logo']) {
	        if ($this->data['config']['logo_width'] && $this->data['config']['logo_height']) {
	            $this->load->model('tool/image');
	            
	            $this->model_tool_image = new ModelToolImage($this->registry);
	            
	        	$this->data['config']['logo'] = $this->model_tool_image->resize($this->data['config']['logo'], $this->data['config']['logo_width'], $this->data['config']['logo_height']);
	        } else {
	        	$this->data['config']['logo'] = $this->getImageUrl($this->data['config']['logo']);
	        }
        } else {
        	unset($this->data['config']['logo']);
        }
        
        return $this;
    }

	/**
	 * @param string $filename 
	 * @param string $content - if $filename is null then the content will be used as the body
	 * @param string $wrapper
	 * 
	 * @returns string
	 */
	public function fetch($filename = null, $content = null, $wrapper = '_main.tpl') {
		if (!$this->isLoaded()) return false;

		if (!$this->built) {
			$this->build();
		}

		$this->html = '';
		$this->content = '';
		
		if (!is_null($filename)) {
			$this->content = $this->fetchTemplate($filename);
		} elseif (!is_null($content)) {
			$this->content = html_entity_decode($content, ENT_QUOTES, 'UTF-8');
		}

		if ($this->content) {
    		$wrapper = $this->fetchTemplate($wrapper);    
    		if ($wrapper) {
    		    $this->html = str_ireplace('{CONTENT}', $this->content, $wrapper);
    		} else {
    		    $this->html = $this->content;
    		}    		
		}

		return $this->html;
	}
	
	/**
	 * Property
	 */
	public function get($key) {
		//if (property_exists($this, $key)) {
		if (isset($this->$key) && $key[0] != '_') {
			return $this->$key;
		}
	}
	public function set($key, $val) {
		if (isset($this->$key) && $key[0] != '_') {
			$this->$key = $val;
			return true;
		}
		return false;
	}

	/**
	 * Appends template data
	 *
	 * [code]
	 * $template->addData($my_data_array, 'prefix'); // array(prefix)
	 * $template->addData('my_value', $my_value); // string=key,value
	 *
	 * @return object
	 */
	public function addData($param1, $param2 = '') {
		if (is_array($param1)) {
			// $param2 acts as prefix
			if ($param2) {
				$param2 = rtrim($param2, "_") . "_";
				foreach ($param1 as $key => $value) {
					$param1[$param2.$key] = $value;
					unset($param1[$key]);
				}
			}
			$this->data = array_merge($this->data, $param1);
		} elseif (is_string($param1) && $param2 != "") {
			$this->data[$param1] = $param2;
		}

		return $this;
	}

	/**
	 * Appends $this->data with $data
	 *
	 * @deprecated left in for compatibility
	 */
	public function appendData($data) {
		return $this->addData($data);
	}
	
	/**
	 * Appends $this->data with data from language (using $language->get)
	 *
	 * @param mixed $language
	 * @param array $keys - (int => key) - copies $language[key] to $this->data[key];
	 * 						(key1 => key2) - copies $language[key1] to $this->data[key2]
	 * 
	 * @deprecated left in for compatibility
	 */
	public function appendDataLanguage($language, $keys) {
	    foreach ($keys as $idx => $key) {
	        if (is_integer($idx)) {
	            $this->data[$key] = $language->get($key);
	        } else {
	            $this->data[$key] = $language->get($idx);
	        }
	    }
	}


	/******************************************************************************
	 * Copyright (c) 2010 Jevon Wright and others.
	* All rights reserved. This program and the accompanying materials
	* are made available under the terms of the Eclipse Public License v1.0
	* which accompanies this distribution, and is available at
	* http://www.eclipse.org/legal/epl-v10.html
	*
	* Contributors:
	*    Jevon Wright - initial API and implementation
	****************************************************************************/
	/**
	 * Tries to convert the given HTML into a plain text format - best suited for
	* e-mail display, etc.
	*
	* <p>In particular, it tries to maintain the following features:
	* <ul>
	*   <li>Links are maintained, with the 'href' copied over
	*   <li>Information in the &lt;head&gt; is lost
	* </ul>
	*
	* @param html the input HTML
	* @return the HTML converted, as best as possible, to text
	*/
	public function getPlainText($html = null) {
		if (is_null($html)) {
			$html = $this->html;
		}

		$dom = new DOMDocument('1.0', 'UTF-8');
		
		if ($html && $dom->loadHTML($html)){
			$html = $this->_html_to_plain_text($dom->getElementById('emailPage'));
			
			return $html;
		}
	}

	/**
	 * Get HTML email template
	 */
	public function getHtml() {
		if ($this->html === null) {
			$this->fetch();
		}
		return $this->html;
	}

	/**
	 * Image Absolute URL, no resize
	 */
	public function getImageUrl($filename) {
		if (!file_exists(DIR_IMAGE . $filename) || !is_file(DIR_IMAGE . $filename)) {
			return;
		}

		if ($this->config->get('config_url')) {
			$url = $this->config->get('config_url') . 'image/';
		} else {
			$url = defined("HTTP_IMAGE") ? HTTP_IMAGE : (defined("HTTP_CATALOG") ? HTTP_CATALOG : HTTP_SERVER) . 'image/';
		}

		return $url . $filename;
	}

	/**
	 * Get Template Path
	 */
	protected function _getTemplatePath($file) {
		if (defined('DIR_CATALOG')) {
			if (file_exists(DIR_TEMPLATE.'mail/'.$file)) {
				$path = DIR_TEMPLATE.'mail/';
			} elseif (isset($this->data['config']['theme']) && file_exists(DIR_CATALOG.'view/theme/'.$this->data['config']['theme'].'/template/mail/'.$file)) {
				$path = DIR_CATALOG.'view/theme/'.$this->data['config']['theme'].'/template/mail/';
			} elseif ($this->config->get('config_template') && file_exists(DIR_CATALOG.'view/theme/'.$this->config->get('config_template').'/template/mail/'.$file)) {
				$path = DIR_CATALOG.'view/theme/'.$this->data['config']['theme'].'/template/mail/';
			} else {
				$path = DIR_CATALOG.'view/theme/default/template/mail/';
			}
		} else {
			if (isset($this->data['config']['theme']) && file_exists(DIR_TEMPLATE.$this->data['config']['theme'].'/template/mail/'.$file)) {
				$path = DIR_TEMPLATE.$this->data['config']['theme'].'/template/mail/';
			} elseif ($this->config->get('config_template') && file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/mail/'.$file)) {
				$path = DIR_TEMPLATE.$this->data['config']['theme'].'/template/mail/';
			} else {
				$path = DIR_TEMPLATE.'default/template/mail/';
			}
		}

		return $path;
	}

	/**
	 * Get Email Wrapper Filename
	 *
	 * @param string - filename
	 * @return object - EmailTemplate
	 */
	public function fetchTemplate($file) {
		if (!$file) return false;

		$path = $this->_getTemplatePath($file);

		if (file_exists($path.$file)) {
			extract($this->data);

			ob_start();

			include(modification($path.$file));

			$content = ob_get_contents();

			if (ob_get_length()) ob_end_clean();

			return $content;
		}
	}

	/**
	 * Generate array of hex values for shadow
	 * @param $from - HEX colour from
	 * @param $until - HEX colour from
	 * @param $length - distance of shadow
	 * @return Array(hex=>width)
	 */
	private function _generateGradientArray($from, $until, $length) {
	$from = ltrim($from,'#');
		$until = ltrim($until,'#');
		$from = array(hexdec(substr($from,0,2)),hexdec(substr($from,2,2)),hexdec(substr($from,4,2)));
		$until = array(hexdec(substr($until,0,2)),hexdec(substr($until,2,2)),hexdec(substr($until,4,2)));

		if ($length > 1) {
			$red=($until[0]-$from[0])/($length-1);
			$green=($until[1]-$from[1])/($length-1);
			$blue=($until[2]-$from[2])/($length-1);
			$return = array();

			for($i=0;$i<$length;$i++) {
				$newred=dechex($from[0]+round($i*$red));
				if (strlen($newred)<2) $newred="0".$newred;

				$newgreen=dechex($from[1]+round($i*$green));
				if (strlen($newgreen)<2) $newgreen="0".$newgreen;

				$newblue=dechex($from[2]+round($i*$blue));
				if (strlen($newblue)<2) $newblue="0".$newblue;

				$hex = $newred.$newgreen.$newblue;
				if (isset($return[$hex])) {
					$return[$hex] ++;
				} else {
					$return[$hex] = 1;
				}
			}
			return $return;
		} else {
			$red=($until[0]-$from[0]);
			$green=($until[1]-$from[1]);
			$blue=($until[2]-$from[2]);

			$newred=dechex($from[0]+round($red));
			if (strlen($newred)<2) $newred="0".$newred;

			$newgreen=dechex($from[1]+round($green));
			if (strlen($newgreen)<2) $newgreen="0".$newgreen;

			$newblue=dechex($from[2]+round($blue));
			if (strlen($newblue)<2) $newblue="0".$newblue;

			return array($newred.$newgreen.$newblue => $length);
		}

	}

	public static function truncate_str($str, $length = 100, $breakWords = true, $append = '...') {
		$str = strip_tags(html_entity_decode($str, ENT_QUOTES, 'UTF-8'));

		$strLength = utf8_strlen($str);
		if ($strLength <= $length) {
			return $str;
		}

		if (!$breakWords) {
			while ($length < $strLength AND preg_match('/^\pL$/', mb_substr($str, $length, 1))) {
				$length++;
			}
		}

		$str = utf8_substr($str, 0, $length) . $append;
		$str = preg_replace('/\s{3,}/',' ', $str);
		$str = trim($str);

		return $str;
	}

	// Works on both HTML, and XHTML
	// Sent in from developer @gob33 of 'Package Tracking Service'.
	public static function isHTML($str) {
		$html = array('A','ABBR','ACRONYM','ADDRESS','APPLET','AREA','B','BASE','BASEFONT','BDO','BIG','BLOCKQUOTE',
			'BODY','BR','BUTTON','CAPTION','CENTER','CITE','CODE','COL','COLGROUP','DD','DEL','DFN','DIR','DIV','DL',
			'DT','EM','FIELDSET','FONT','FORM','FRAME','FRAMESET','H1','H2','H3','H4','H5','H6','HEAD','HR','HTML',
			'I','IFRAME','IMG','INPUT','INS','ISINDEX','KBD','LABEL','LEGEND','LI','LINK','MAP','MENU','META',
			'NOFRAMES','NOSCRIPT','OBJECT','OL','OPTGROUP','OPTION','P','PARAM','PRE','Q','S','SAMP','SCRIPT',
			'SELECT','SMALL','SPAN','STRIKE','STRONG','STYLE','SUB','SUP','TABLE','TBODY','TD','TEXTAREA','TFOOT',
			'TH','THEAD','TITLE','TR','TT','U','UL','VAR');

		return preg_match("~(&lt;\/?)\b(".implode('|', $html).")\b([^>]*&gt;)~i", $str, $c);
	}

	private function _html_to_plain_text($node) {
		if ($node instanceof DOMText) {
			return preg_replace("/\\s+/im", " ", $node->wholeText);
		}
		if ($node instanceof DOMDocumentType) {
			// ignore
			return "";
		}

		// Next
		$nextNode = $node->nextSibling;
		while ($nextNode != null) {
			if ($nextNode instanceof DOMElement) {
				break;
			}
			$nextNode = $nextNode->nextSibling;
		}
		$nextName = null;
		if ($nextNode instanceof DOMElement && $nextNode != null) {
			$nextName = strtolower($nextNode->nodeName);
		}

		// Previous
		$nextNode = $node->previousSibling;
		while ($nextNode != null) {
			if ($nextNode instanceof DOMElement) {
				break;
			}
			$nextNode = $nextNode->previousSibling;
		}
		$prevName = null;
		if ($nextNode instanceof DOMElement && $nextNode != null) {
			$prevName = strtolower($nextNode->nodeName);
		}

		$name = strtolower($node->nodeName);

		// start whitespace
		switch ($name) {
			case "hr":
				return "------\n";

			case "style":
			case "head":
			case "title":
			case "meta":
			case "script":
				// ignore these tags
				return "";

			case "h1":
			case "h2":
			case "h3":
			case "h4":
			case "h5":
			case "h6":
				// add two newlines
				$output = "\n";
				break;

			case "p":
			case "div":
				// add one line
				$output = "\n";
				break;

			default:
				// print out contents of unknown tags
				$output = "";
				break;
		}

		// debug $output .= "[$name,$nextName]";

		if ($node->childNodes) {
			for ($i = 0; $i < $node->childNodes->length; $i++) {
				$n = $node->childNodes->item($i);

				$text = $this->_html_to_plain_text($n);

				$output .= $text;
			}
		}

		// end whitespace
		switch ($name) {
			case "style":
			case "head":
			case "title":
			case "meta":
			case "script":
				// ignore these tags
				return "";

			case "h1":
			case "h2":
			case "h3":
			case "h4":
			case "h5":
			case "h6":
				$output .= "\n";
				break;

			case "p":
			case "br":
				// add one line
				if ($nextName != "div")
					$output .= "\n";
				break;

			case "div":
				// add one line only if the next child isn't a div
				if (($nextName != "div" && $nextName != null) || ($node->hasAttribute('class') && strstr($node->getAttribute('class'), 'emailtemplateSpacing')))
					$output .= "\n";
				break;

			case "a":
				// links are returned in [text](link) format
				$href = $node->getAttribute("href");
				if ($href == null) {
					// it doesn't link anywhere
					if ($node->getAttribute("name") != null) {
						$output = "$output";
					}
				} else {
					if ($href == $output || ($node->hasAttribute('class') && strstr($node->getAttribute('class'), 'emailtemplateNoDisplay'))) {
						// link to the same address: just use link
						$output;
					} else {
						// No display
						$output = $href . "\n" . $output;
					}
				}

				// does the next node require additional whitespace?
				switch ($nextName) {
					case "h1": case "h2": case "h3": case "h4": case "h5": case "h6":
						$output .= "\n";
						break;
				}

			default:
				// do nothing
		}

		return $output;
	}
}


/**
 * Data Access Object - Abstract
 */
abstract class EmailTemplateAbstract
{
	/**
	 * Data Types
	 */
	const INT = "INT";
	const TEXT = "TEXT";
	const SERIALIZE = "SERIALIZE";
	const FLOAT = "FLOAT";
	const DATE_NOW = "DATE_NOW";

	/**
	 * Filter from array, by unsetting element(s)
	 * @param string/array $filter - match array key
	 * @param array to be filtered
	 * @return array
	*/
	protected static function filterArray($filter, $array) {
		if ($filter === null) return $array;

		if (is_array($filter)) {
			foreach($filter as $f) {
				unset($array[$f]);
			}
		} else {
			unset($array[$filter]);
		}

		return $array;
	}

}

/**
 * Config `emailtemplate_config`
 */
class EmailTemplateConfigDAO extends EmailTemplateAbstract
{
	/**
	 * Columns & Data Types.
	 * @see EmailTemplateAbstract::describe()
	 */
	public static function describe() {
		$filter = func_get_args();
		$cols = array(
			'emailtemplate_config_id' => EmailTemplateAbstract::INT,
			'emailtemplate_config_name' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_email_width' => EmailTemplateAbstract::INT,
			'emailtemplate_config_page_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_body_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_body_font_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_body_link_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_body_heading_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_body_section_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_page_footer_text' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_footer_text' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_footer_align' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_footer_valign' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_footer_font_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_footer_height' => EmailTemplateAbstract::INT,
			'emailtemplate_config_footer_section_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_header_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_header_bg_image' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_header_height' => EmailTemplateAbstract::INT,
			'emailtemplate_config_header_border_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_header_section_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_head_text' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_head_section_bg_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_logo' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_logo_align' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_logo_font_color' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_logo_font_size' => EmailTemplateAbstract::INT,
			'emailtemplate_config_logo_height' => EmailTemplateAbstract::INT,
			'emailtemplate_config_logo_valign' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_logo_width' => EmailTemplateAbstract::INT,
			'emailtemplate_config_shadow_top' => EmailTemplateAbstract::SERIALIZE,
			'emailtemplate_config_shadow_left' => EmailTemplateAbstract::SERIALIZE,
			'emailtemplate_config_shadow_right' => EmailTemplateAbstract::SERIALIZE,
			'emailtemplate_config_shadow_bottom' => EmailTemplateAbstract::SERIALIZE,
			'emailtemplate_config_text_align' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_page_align' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_theme' => EmailTemplateAbstract::TEXT,
			'emailtemplate_config_status' => EmailTemplateAbstract::INT,
			'emailtemplate_config_version' => EmailTemplateAbstract::TEXT,
			'language_id' => EmailTemplateAbstract::INT,
			'store_id' => EmailTemplateAbstract::INT
		);

		return (!$filter)? $cols : self::filterArray($filter, $cols);
	}
}

?>