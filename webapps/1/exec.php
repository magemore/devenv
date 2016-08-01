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
    $this->prepare();
		return $this;
	}

	private function prepare() {
    /**
    * fortmat. split string by colums
    */
    function clean($s) {
      print_r($s);
      $o=[];
      $o['permission']=substr($s,0,10);
      $o['user']=trim(substr($s,12,2));
      $o['size']=substr($s,17,7);
      $o['next']=substr($s,17,7);
      print_r($o);
      return $s;
    }
	  foreach ($this->files as $i => $file) {
      $this->files[$i]=clean($file);
    }
  }

	public function get() {
	 	return ['total'=>$this->total,$this->files];
	}
		
}

function getExecFiles($shellCommand) {
	return (new Exec($shellCommand))->get();
}
