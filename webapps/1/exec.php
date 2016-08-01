<?php

require_once 'auto_refresh/short.php';

class Exec {
	
	private $files = [];
	private $total = false;

	public function __construct($shellCommand=false)
	{
		$a = wrapper_over_exec($shellCommand);
		if (strpos(strtolower($a[0]),'total')!==FALSE) {
			$this->total = $a[0];
			unset($a[0]);
		}
		$this->files=$a;
		return $this;
	}

	private function prepare($files) {
    /**
    * fortmat. split string by colums
    */
    function clean($s) {
      return $s;
    }
	  foreach ($files as $i => $file) {
      $files[$i]=clean($file);
    }
  }

	public function get() {
	 	return ['total'=>$this->total,$this->files];
	}
		
}

function getExecFiles($shellCommand) {
	return (new Exec($shellCommand))->get();
}
