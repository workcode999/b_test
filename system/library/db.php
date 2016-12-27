<?php
class DB {
	private $db;

	public function __construct($driver, $hostname, $username, $password, $database) {
		//$driver = 'ips' . $driver;
		$class = 'DB\\' . $driver;

		if (class_exists($class)) {
			$this->db = new $class($hostname, $username, $password, $database);
		} else {
			exit('Error: Could not load database driver ' . $driver . '!');
		}
	}
	public function cachedQuery($sql, $cachedir) {
		$this->cachedir = DIR_CACHE . $cachedir . '/';
		$this->cachename = md5($sql);
		$this->filename = $this->cachedir . $cachedir . '.' . $this->cachename;

		if (!$this->cacheExists()) {
			$query =  $this->query($sql);
			$this->saveCache($query);
			return $query;	
		} else {
			$cache = $this->getCache();
			$query = new stdClass();
			$query->row  = !isset($cache['row']) ? array() : $cache['row'];
			$query->rows = !isset($cache['rows']) ? array() : $cache['rows'];
			$query->num_rows = !isset($cache['num_rows']) ? 0 : $cache['num_rows'];
			return $query;		
		}
	}
	
	protected function cacheExists() {
		if (!file_exists($this->filename)) {
			return false;
		} else {
			return true;
		}
	}
	
	protected function getCache() {
		//$data = apc_fetch($this->filename);
		if (!$data = json_decode(file_get_contents($this->filename), true)) {
			return false;
		}
		return $data;
	}

	protected function saveCache($data) {
		//apc_store($this->filename,$data, $this->expires);
		if (!file_put_contents($this->filename, json_encode($data))) {
			return false;
		}
		return true;
	}
	
	public function deleteCache($filename, $wildcard = false) {
		$filename = $this->dir . $filename;
		// If wildcard is set, delete anything file with a prefix of $filename
		if ($wildcard) {
			foreach (glob($filename.'*') as $file) {
				unlink($file);
			}
		} else { // Just deletes file with filename
			if (file_exists($filename)) {
				unlink($filename);
			}
		}
	}
	public function query($sql) {
		return $this->db->query($sql);
	}

	public function escape($value) {
		return $this->db->escape($value);
	}

	public function countAffected() {
		return $this->db->countAffected();
	}

	public function getLastId() {
		return $this->db->getLastId();
	}
}
